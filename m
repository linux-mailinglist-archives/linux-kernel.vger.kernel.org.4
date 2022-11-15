Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA662926C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKOH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiKOH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:27:54 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE25140B3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:27:52 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id k67so13867134vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3sw2WXv//OdozQyPx9VqYqR4BMN84pjXjwEEr0/hNc=;
        b=Gv9Nnj/U/n0gcJl8Ft0kLWr/0V1yZthqU5BOkBYaECLp48Ay8sfkLIoeG5m6oPmOEe
         2zv8v2yTUS0l/8xNIiDqnSy+ZH5pKc/F23GXkS2dYuFYZWfPimzPECa8XMOSXxzsAyaE
         DBOjswg9hNsOhb+UlvxrF0VNtf9FCY99mApB15WQa2pDZIluhnw8tLNGP5U+Bm+GDR/P
         Eijwtts3EDQ+mQq4FyNJI+HyghbXKYpPLD/yeHCjqkTFG8q8Fdgp+nThf0sRw8Jwky8C
         8f5MeDukNzWqhLb7tzp2NqJD4yrtcH6Et5aKVbmWOdUx2h28hLIyy5U8APIjGVU/Iq86
         wgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3sw2WXv//OdozQyPx9VqYqR4BMN84pjXjwEEr0/hNc=;
        b=r/anHhPTDSz+6FrFs6Lva2dQT8/vur4JCs4DYrvJnFVNg0n3Mkfqnlg0O13mA4H5mS
         BIp1QmEmJDe+BXjj7c9/c3/M9Ct3j2TFDk9KhLFLB9fvkgos7uvUo3/EhQ1MFySF16Pc
         nzsivUi+jkRYV6t7HnVA6+RyXWyx1k4hsqx1EeYkbe3O5K58fjx0gxcP3w+OhMi91Ewx
         QIqMJdAgB3ZEqnfsRs6e6TXaWWLMgz2DyMar5LP7YLZI01YggyAR9vrbvIV5Vaaf1lrN
         ZnRhz7nxB6p4AtahLFWi4EIBceKkoQ4WcckC65kwTRQzALrvdbAhmLGW2fyUPsxzgn7V
         hixA==
X-Gm-Message-State: ANoB5pno9uoNcaXhQAyvCpw6tuxvXGBusk2WSHZcm5ox2ZGmGk70j1Gs
        Kg+LOXTjB6IdcwbW6GXzXqGkiQkdemJAjspn7u2hdQ==
X-Google-Smtp-Source: AA0mqf5YlhZJUhFrBHr6c0gb/ZyLOX8gnHJ9jd7hWmeVLk5qFrxVyG025yC2r/Y7BawyHEYIAbWbfmr24kIOpymnmxc=
X-Received: by 2002:a67:ee59:0:b0:3aa:172c:340f with SMTP id
 g25-20020a67ee59000000b003aa172c340fmr8390965vsp.71.1668497271278; Mon, 14
 Nov 2022 23:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com>
In-Reply-To: <20221104194705.3245738-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Nov 2022 15:27:39 +0800
Message-ID: <CABVgOSnUDNvs6mYwVtzXq3+PmO62HG1pP=d_6EQiwOKF_9D6XA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Isabella Basso <isabbasso@riseup.net>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f62f305ed7d4b5e"
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

--0000000000002f62f305ed7d4b5e
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 5, 2022 at 3:48 AM Rae Moar <rmoar@google.com> wrote:
>
> Change KUnit test output to comply with KTAP version 1 specifications
> found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> 2) Remove '-' between test number and test name on test result lines
> 2) Add KTAP version lines to each subtest header as well
>
> Original output:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> New output:
>
>  KTAP version 1
>  1..1
>    # Subtest: kunit-test-suite
>    KTAP version 1
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks very much for doing this. It's always been slightly
embarrassing that we weren't perfectly following our own spec!

I think this series is good enough, but have a minor suggestion: could
we swap the order of these two patches?
I'd rather have the parser changes go in first.

I'd also be curious to see if this is likely to break anyone else's
(K)TAP parsers.

+Isabella, Anders: do these changes break the IGT or LKFT TAP/KTAP
parsing? From a quick look at [1] and [2], we're probably okay??

[1]: https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/commit/1a84306425e975377eb79c031bf1de147bd44e46
[2]: https://github.com/Linaro/test-definitions/blob/master/automated/linux/kunit/kunit.sh

I also looked into the possibility of moving or removing the Subtest
line, but upon further thought (see below), it's probably best to keep
it as-is here for now. That should be the closest to the current spec,
and we can possibly find a better way to provide the name in KTAPv2.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/executor.c | 6 +++---
>  lib/kunit/test.c     | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 9bbc422c284b..74982b83707c 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
>  {
>         size_t num_suites = suite_set->end - suite_set->start;
>
> -       pr_info("TAP version 14\n");
> +       pr_info("KTAP version 1\n");
>         pr_info("1..%zu\n", num_suites);
>
>         __kunit_test_suites_init(suite_set->start, num_suites);
> @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
>
> -       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> -       pr_info("TAP version 14\n");
> +       /* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
> +       pr_info("KTAP version 1\n");
>
>         for (suites = suite_set->start; suites < suite_set->end; suites++)
>                 kunit_suite_for_each_test_case((*suites), test_case) {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 90640a43cf62..b541d59a05c3 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -151,6 +151,7 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
>                   suite->name);
> +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");

Would it make sense to have the Subtest line _after_ the KTAP line here?

Given KTAP doesn't specify the "Subtest" line at all, I guess it doesn't matter.

A part of me feels that the "KTAP version 1" line should be the
_first_ line of the subtest output, but that would introduce a line
between it and the test plan, which goes against the spec.

We could also just get rid of the "Subtest" line, given it's not
technically required, though having the test name before the results
is really useful.

Having tried all three options while writing this email, I think it's
probably best to leave this patch as is (with the Subtest line
followed by the KTAP line), and discuss standardising something
similar as part of the KTAP v2 spec.


>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
>                   kunit_suite_num_test_cases(suite));
>  }
> @@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>          * representation.
>          */
>         if (suite)
> -               pr_info("%s %zd - %s%s%s\n",
> +               pr_info("%s %zd %s%s%s\n",
>                         kunit_status_to_ok_not_ok(status),
>                         test_number, description, directive_header,
>                         (status == KUNIT_SKIPPED) ? directive : "");
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> +                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
>                           (status == KUNIT_SKIPPED) ? directive : "");
>
> base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
> --
> 2.38.1.431.g37b22c650d-goog
>

--0000000000002f62f305ed7d4b5e
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDV
f7zIMxHfsdvNvPDEAEkEd9U68PPM6aW+ZmskxUCZHzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTUwNzI3NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYK/VEwDUEBPNfQZHSP93
ObencfKiTJwnNnNqpu+Buz9SX56aMe3nM6EPdYVp7IoZwXGWs+uo+UizvE7tZObWYaKXJFdoUY5r
KAE7aWTePcCfZHASQKM74IHbwtQ6tqsFRdJghb7g9F08IiVolBTkdd3be4HPasxPy+4F/nGvxYIo
BTIITKiT8zXJqE8fa8tyIlXvx6KCoMrBMuF01uQv/vwluhwSJrBnf3D/Ka3E/a/wGVCwOs3yQISI
mI5PReeOmj8O56+2n6aBWxEZu7AS/lAR12el7cRow8sbORYghz5kI7XomEsxdVTL2FHMd/E7qn2q
m3F3Svhd3Zn2QLX7Gw==
--0000000000002f62f305ed7d4b5e--
