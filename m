Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5023F670F08
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjARAuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjARAtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:49:15 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04A4708A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:37:38 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id w72so15679084vkw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fq7haCMuEgOBe7SPV2lldZ37ovTSLCjyQMKUeIzFb3M=;
        b=Io8hl+dAbGftyhN0JG3Sxo3kdZn5p56DpXAnq/okZdpgoIFtUdYlnKnK3UeGqDcUXl
         BzERzlvL18un+2YEcOkxpX+RoPuNAgSq1C9s25xzZd8/wPNtV1Q1S0dD9iPHyBwGmb1y
         gN7tSfcll1W+k3tJT82yVGx+O7FRp7n3WKMa0CdkMde/o360WiOdtL01wPKq+ZzqtyGc
         4PQqsAHAIUpN3iKJ5mJ1ZoAFSWE68taxYBLhJCGI68P/UOAsEA42XJKdR16XaKQ4wdiT
         R9yn759as8VDsumN1avCodtDJsxy7RKfMSG+lo2x7LaT0bZfgX8sCli7wvqafnDY38+B
         1N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq7haCMuEgOBe7SPV2lldZ37ovTSLCjyQMKUeIzFb3M=;
        b=FOC5q3+vd9m1/DslwkambpPOaX16DFI2zfAEEZ1OwATLDdCGF4bnBGmLHNNwt5qicl
         rk4cnB/HnmRRpD39UlZAXW1Hkn60zBvSe+6dW+Co5YUBuU9dsEc8T8+GpwsKhFsXMdDV
         1gVZ3VfXm3DgWC2UUUcz4Uuou6GRusI10OZ+CkuUedAEHhpRmAZmJuh4EOFqSvB31ezd
         zkpUGKN0Kr8eiFocpukHMKTIkbU2LjcoMk5mXiewUvB+EQqadJwZ/q+R803cLkDFHQDZ
         rEq8P0kW/kw4S8nAWPlmPwx6Uvp9MvloZFbOAtapl3rrNsN2Pr+dH2dHV4c/ww+4b6d6
         ShDg==
X-Gm-Message-State: AFqh2kowecNdf0f69Y9Iolh7Csu/oDRrZiILpwc43WNtZU5iwxfiPkaN
        rc+9oNi6IEhnoE8IXf206WNRx9oSnIo//Zj3EY2rrg==
X-Google-Smtp-Source: AMrXdXs9LbHrGn72PskfRDv6X4mqgaDc5tqDFS6dbiaht+hFdOb4woKk7L+cPuE5O8RjtHLIvJXG7DvFbaEqoLcW2TE=
X-Received: by 2002:a1f:e681:0:b0:3e1:77d6:33bf with SMTP id
 d123-20020a1fe681000000b003e177d633bfmr687347vkh.34.1674002257998; Tue, 17
 Jan 2023 16:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20230117165039.1871598-1-arnd@kernel.org>
In-Reply-To: <20230117165039.1871598-1-arnd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 18 Jan 2023 08:37:26 +0800
Message-ID: <CABVgOSnAFM3HozugcOdmgEBja7Q5n1OYkV+ZJ+uFnCaWDTVneQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Export kunit_running()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joe Fradley <joefradley@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f53ae805f27f0533"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f53ae805f27f0533
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jan 2023 at 00:50, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using kunit_fail_current_test() in a loadable module causes a link
> error like:
>
> ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko] undefined!
>
> Export the symbol to allow using it from modules.
>
> Fixes: da43ff045c3f ("drm/vc4: tests: Fail the current test if we access a register")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for fixing this!

I think the longer-term solution for this is the "hooks" approach
(which works even when KUnit itself is built as a module):
https://lore.kernel.org/all/20230117142737.246446-1-davidgow@google.com/

But this looks good to fix it in the meantime.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9ebf975e56b..890ba5b3a981 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -21,6 +21,7 @@
>  #include "try-catch-impl.h"
>
>  DEFINE_STATIC_KEY_FALSE(kunit_running);
> +EXPORT_SYMBOL_GPL(kunit_running);
>
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  /*
> --
> 2.39.0
>

--000000000000f53ae805f27f0533
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDo
UM52+0bdLc+2bl85GHHy6AAlcfxWRlhGJgpJd9kKgzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTgwMDM3MzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAtVwYi42Qob2mwcnSyglu
GAiuzCIRN71rOIjOZbCfWm2Ra88XXoaIG5/jQ/pjLB5nxWzFrFREVt6MVpVSQDARQHl+YWjjY4wR
p7VXhodZUpIJ48KwwO68sKRIbEoR7aiKbY2AA6GRpFOLwrmlQMZkPOa0fN/6Qco2gxYujjmqmMYW
kI0kW859IZ0HuD745dUUmZrY6GMgj9hzPi6Rsgfd6JviDRmjRAiDoy7Q32/5cT5aLXSvZ/Jhyjdd
1pyRWMp58sjZX4YPNVX37colLzMlozTZz/dR03iOSnw6NmN2E0m6ILrlKjR+VgZJkigArviyojfC
ZeLf/l1Z8QZgmZjrlA==
--000000000000f53ae805f27f0533--
