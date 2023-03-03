Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3C6A979A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCCMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCCMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:53:05 -0500
Received: from mailout2n.rrzn.uni-hannover.de (mailout2n.rrzn.uni-hannover.de [130.75.2.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF2658C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:52:59 -0800 (PST)
Received: from [10.23.33.223] (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 7A7131F505;
        Fri,  3 Mar 2023 13:52:57 +0100 (CET)
Message-ID: <0952ab0d-d640-decb-2f20-57881e45ab52@sra.uni-hannover.de>
Date:   Fri, 3 Mar 2023 13:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm, page_alloc: batch cma update on pcp buffer refill
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
 <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
Content-Language: en-US, de-DE
From:   Alexander Halbuer <halbuer@sra.uni-hannover.de>
In-Reply-To: <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms070403090101050907080108"
X-Virus-Scanned: clamav-milter 0.103.8 at mailout2n
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070403090101050907080108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/23 11:27, Vlastimil Babka wrote:
> Incidentally, did you observe any improvements by [2] with your test,
> especially as the batch freeing side also no longer does checking under zone
> lock?
> 
> Thanks!
> 

I finally managed to repeat the benchmark to see the effects of
disabling alloc and free sanity checks by default ("mm, page_alloc:
reduce page alloc/free sanity checks"; results below).

Average huge page allocation latency drastically reduces by over 90% in
the single core case. However i can't see any real improvements for the
free operation.

---

Measurement results for the batch allocation benchmark for different
core counts: Internally used functions are alloc_pages_node() for
allocation (get) and __free_pages() for free (put).

Compared kernel versions are from the mm-unstable branch:
- Reference version (without the mentioned patch):
daf4bcbf2b72 ("mm: cma: make kobj_type structure constant")
- Patched version:
60114678f165 ("mm-page_alloc-reduce-page-alloc-free-sanity-checks-fix")

Normale pages
+-------+------+-------+---------+------+-------+---------+
| cores | base | patch |    diff | base | patch |  diff   |
|       |  get |   get |     get |  put |   put |   put   |
|       | (ns) |  (ns) |         | (ns) |  (ns) |         |
+-------+------+-------+---------+------+-------+---------+
|     1 |  122 |   118 | (-3.3%) |  118 |   116 | (-1.7%) |
|     2 |  133 |   130 | (-2.3%) |  130 |   123 | (-5.4%) |
|     3 |  136 |   132 | (-2.9%) |  175 |   162 | (-7.4%) |
|     4 |  161 |   149 | (-7.5%) |  241 |   226 | (-6.2%) |
|     6 |  247 |   228 | (-7.7%) |  366 |   344 | (-6.0%) |
|     8 |  331 |   304 | (-8.2%) |  484 |   456 | (-5.8%) |
|    10 |  416 |   390 | (-6.2%) |  615 |   578 | (-6.0%) |
|    12 |  502 |   472 | (-6.0%) |  727 |   687 | (-5.5%) |
|    14 |  584 |   552 | (-5.5%) |  862 |   816 | (-5.3%) |
|    16 |  669 |   632 | (-5.5%) |  967 |   923 | (-4.6%) |
|    20 |  833 |   787 | (-5.5%) | 1232 |  1164 | (-5.5%) |
|    24 |  999 |   944 | (-5.5%) | 1462 |  1384 | (-5.3%) |
+-------+------+-------+---------+------+-------+---------+

Huge Pages
+-------+------+-------+----------+-------+-------+---------+
| cores | base | patch |     diff |  base | patch |  diff   |
|       |  get |   get |      get |   put |   put |   put   |
|       | (ns) |  (ns) |          |  (ns) |  (ns) |         |
+-------+------+-------+----------+-------+-------+---------+
|     1 | 3148 |   177 | (-94.4%) |  2946 |  2872 | (-2.5%) |
|     2 | 3404 |   596 | (-82.5%) |  3318 |  3306 | (-0.4%) |
|     3 | 3581 |   950 | (-73.5%) |  3401 |  3358 | (-1.3%) |
|     4 | 3651 |  1284 | (-64.8%) |  3562 |  3616 | (1.5%)  |
|     6 | 3568 |  1929 | (-45.9%) |  4478 |  4564 | (1.9%)  |
|     8 | 3605 |  2328 | (-35.4%) |  5658 |  5546 | (-2.0%) |
|    10 | 4093 |  2935 | (-28.3%) |  6758 |  6457 | (-4.5%) |
|    12 | 4778 |  3540 | (-25.9%) |  7698 |  7565 | (-1.7%) |
|    14 | 5565 |  4097 | (-26.4%) |  8748 |  8810 | (0.7%)  |
|    16 | 6364 |  4725 | (-25.8%) |  9942 | 10103 | (1.6%)  |
|    20 | 8014 |  5915 | (-26.2%) | 12509 | 12772 | (2.1%)  |
|    24 | 8732 |  7138 | (-18.3%) | 15217 | 15433 | (1.4%)  |
+-------+------+-------+----------+-------+-------+---------+

>>
>> [1] https://lore.kernel.org/lkml/1d468148-936f-8816-eb71-1662f2d4945b@suse.cz/
>> [2] https://lore.kernel.org/linux-mm/20230216095131.17336-1-vbabka@suse.cz/

--------------ms070403090101050907080108
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
EgkwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIHPzCCBiegAwIBAgIMJ8KH8L167ltSNxQDMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIyMTIyMTEzMzAxMVoXDTI1MTIy
MDEzMzAxMVowgdQxCzAJBgNVBAYTAkRFMRYwFAYDVQQIDA1OaWVkZXJzYWNoc2VuMREwDwYD
VQQHDAhIYW5ub3ZlcjEmMCQGA1UECgwdTGVpYm5peiBVbml2ZXJzaXRhZXQgSGFubm92ZXIx
MDAuBgNVBAsMJ1N5c3RlbXMgUmVzZWFyY2ggYW5kIEFyY2hpdGVjdHVyZSBHcm91cDEQMA4G
A1UEBAwHSGFsYnVlcjESMBAGA1UEKgwJQWxleGFuZGVyMRowGAYDVQQDDBFBbGV4YW5kZXIg
SGFsYnVlcjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMdDQXnL6b7HbxxclJcX
nVe2jVEY4wU6Jd9zi5ssV3IyaYsZAErUyYhF09p/znIdR38b8sDN7tiaQhhay3dV+wa6Ssgw
1xv57Nhj+JoQzNfoHaWG7hoYa5DK9WJWSoV2ekOJU3AaKziHEfedpDw+xj5b/oCg6K7FMRm/
WPzJ3Ce0M7R0m4y3yYuowrdV6usu9n5h8s0Bm8pdQ1+bp1i8Vrq13uSXW2h/td2Hh+v9Cqiq
Adl1tYQPHH+rEufIKlu8UOPW3+/pZpEUaOvDInmMvVhF1e1EFyEVQTovgXcU/wPsG1wIyuGI
WZ9jZSMuugHBL3dioVvk2DwinNZ2iM/Yq6H+Yhvmn9V+GMis5ClF9D14q4t4sP4aG+Xzvkn2
TnAuiXwZ6oFerHVhcWmlcc6HZRHUiGiajq63LyVB5gPQ+QqKjJKYeqk5UiSYQ7gQ8dJ4KoEi
sLGr8wRdDjH4rOD3gnDCWH9c0QqHiSgnPigPSDjePvJt62NJPrJBMTnGVwoUCjQoWPD8ic1+
UZ3qdWk0S1XfvdAJkRQ5LLKhiAqdX+CrKPGSfNJnOK4ggjsOfC8qIh1ZsOvI05qat/1fnJGX
Axaj8kwAuVbapmhxx5Mo9M5q8lbI/QG+NgQjCL9c81YPJ6J4PAJYDBnkZ1Ok+1qUXuJhPoq8
0nqhuFJDY3+NNuHJAgMBAAGjggJUMIICUDA+BgNVHSAENzA1MA8GDSsGAQQBga0hgiwBAQQw
EAYOKwYBBAGBrSGCLAEBBAswEAYOKwYBBAGBrSGCLAIBBAswCQYDVR0TBAIwADAOBgNVHQ8B
Af8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBRgjO56
KZl79n+0D7zfK+uX0++ZcDAfBgNVHSMEGDAWgBRrOpiL+fJTidrgrbIyHgkf6Ko7dDAmBgNV
HREEHzAdgRtoYWxidWVyQHNyYS51bmktaGFubm92ZXIuZGUwgY0GA1UdHwSBhTCBgjA/oD2g
O4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2Fj
cmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIv
cHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRw
Oi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6
Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5j
cnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1n
Mi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAFXaBhBkmar2asm9
xuNtpz0aIaQbkdHMgR+m3ZRY46kwckhPaORW6fdIJaiH4K4BuKLjpgTmK5xagEQ9g0mSzGfc
eEKn3YrPBstHrtzvA9WbOg/QLOBLeXJ1VurE4vWBy0wUNV661bwR2IapYGxquGXlEqC3fbw5
tO7lK/LzrVgap6emGvbDhZ8Xldvz9R/vP2Hpq7cxjQKVrh+qmvp5DPsU1zCLCZ56rDMpiVHW
hSC4qAZR5eV/+zZu1fYaFKi/tDCuw1zGzhmB2fRCyeoDVRcOYFYfVJxc0oK2mTXJUKP35+vj
+bxJxHnR15wt55tnrub4YeAOaU7Bv6bbs6WT+ckxggUrMIIFJwIBATCBnjCBjTELMAkGA1UE
BhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4g
Rm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZO
LVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJ8KH8L167ltSNxQDMA0GCWCGSAFlAwQCAwUA
oIICXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzAzMDMx
MjUyNTdaME8GCSqGSIb3DQEJBDFCBECfeEJRzmf3l0ZO0A1jXldGE6fb7paZQjdcoWfItCg4
7TcXwr5Kx9z2Ws/13I/Z094kPO72UoG0ESgcCiGp/CcQMGwGCSqGSIb3DQEJDzFfMF0wCwYJ
YIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga8GCSsGAQQBgjcQBDGBoTCB
njCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5l
cyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTEl
MCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJ8KH8L167ltSNxQDMIGx
BgsqhkiG9w0BCRACCzGBoaCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6
dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQ
MA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBD
QQIMJ8KH8L167ltSNxQDMA0GCSqGSIb3DQEBAQUABIICAEj5ik0lfw5NaVW6pZ0pM7gJBQml
9UDs/XHfOhwuTieLyvlylGixn38hyv30pULcYnUJEojN1offTRt8FOXfAyKLXX2AaH7b0Yaa
obIC0dnNeZLSiI3RrU+5pC/EyET3kHHWjcHIhiEk20V/kdT0EdDKLU8LFtb47y2IMwILMksi
3tSB2BPLilCQEJxsXYTDDPwmxQ4CNeSCbLytlN7ZLUfRNKgA5A82xdzHrPhdWprsM6yBd0OZ
AayzNOaxKyEKa+I0a6iy9HT5pKXQNfObonNzDeIvLED2mnyR8WCgU+9WnVv0eUBu4Q29AEqh
68KoIRWpWIBPn+0yLVpjsTc1ZTamUcUNPFaVMm9xAnwQ82fwHFXL+hWmU3a4YHc4kvx9qvDO
cvkXl8OTGiX8QY8WQVyd1TDrLAKffcLa6HEWkAlEfWANfRkfOPF638oWbEsu1yzVAdH5QZGL
HdohZyvU7NjRXTFw0bnaeNBU2Vko4oJhke8v0XUYqzRcJg81lokEQoIVjQQL0OuiQOHH9RQI
pa1JsPZ5bvAg7BYFrP3Ub1dkpu8wPd7FCoYC71kMS61Vp1E0xuRk2cpNJekFf6uDGu05baOJ
0vN+2i/en38gFamoVBIMsicyc8nPqTXYpaTBNyt26IiVaxFVgtg0D2RwH/H8MXzS96SOEeFP
a4NyAIKVAAAAAAAA
--------------ms070403090101050907080108--
