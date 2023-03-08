Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155F6AFE16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHFFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCHFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:05:14 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCAA42C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 21:05:11 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id a3so14454203vsi.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 21:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678251910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t50OboYOBo6Kwn59nmNg1Wb+qTSp8/MnJeuYR2ODiig=;
        b=U3yj79hLdry+huPspboM1keSYhOIDNMNusv7GlM77v68JcB3EtFZ/k8rB997PVhXK7
         F25W4NahsvA+mt4ECsGzzoiTJzHN4YC01L1LlcVaObyIThD4wG58IDgMDrwiTIBzVro5
         59qDXRt079fdDaaw4a6xndXj88cbQUwBJG4HV7URp78eFXj1Hoavy5t9EEbSEOS3YMcL
         iqWo0MyKKmPmpEfG5qMGGOSzmKzGmICIL2eF+Jsrw5khs/+c9HOK5F6e0+/ZKBhDoCPe
         CuNKoZ+TvIZUNqBcgkGao5UKpbyKG95k79DoPPeW93EQxUUWm4jW6zORzunSTCUcktxx
         30sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678251910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t50OboYOBo6Kwn59nmNg1Wb+qTSp8/MnJeuYR2ODiig=;
        b=BbTCAGOhPux6AJ4T8z7Ro4KDigUG3F7gU8t/g1k5wY47naIy8GMUZaGeuHK2jzVLf4
         3GkpvhO2hR1gOU6lrS4k54QlQERyh1aZDmKml714OMipSrXN2SlhCO02uG4SUiGzoInL
         pQ2fo+JogrX6fXDfCdV2N9CvIFvTdI8PFF+xhH4KIXqc3vI4jBxTeqDHvBlQnRQbN84J
         QW83bkdao7OVahjEBtpCreUz1TLZf3KIZuWEfEmjAJKP5LuQfUOGOouXXNfo45+tgjRa
         M8hDCZPHOAMOM0Da1quP6qhOfqpYWGCVzicenMugJ+DR2xg4dFhp2fa2qf13KEZ7ZHY+
         3FmQ==
X-Gm-Message-State: AO0yUKUSCSz5lsKMKRHCyPN8ysJIXQ6Mr8vKl1UuPuLS8ISZ9CrZt0T2
        H2CxrJLjy6aKxwC2RefSmAFkdv1ex2NcsP2AyfmUqB6BWcJI+EzK/+8WOQ==
X-Google-Smtp-Source: AK7set89+ahxNOaXL8/a/L/IEVFenvqmdSn4jGMdIzQVVmOl4DN1Jojz064Dt492j2mVPJm47NLbUjDs6Ak7ywKTQz0=
X-Received: by 2002:a05:6102:2743:b0:412:25b3:10f3 with SMTP id
 p3-20020a056102274300b0041225b310f3mr11564831vsu.7.1678251910147; Tue, 07 Mar
 2023 21:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20230307223937.2892762-1-rmoar@google.com> <20230307223937.2892762-2-rmoar@google.com>
In-Reply-To: <20230307223937.2892762-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 8 Mar 2023 13:04:59 +0800
Message-ID: <CABVgOSmgtssQCcoH2FROr2aXP8uKDhHCQKjHD9QkeF_WmGd7-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: fix bug in the order of lines in debugfs logs
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f8d01405f65c78e8"
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

--000000000000f8d01405f65c78e8
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Mar 2023 at 06:39, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug in debugfs logs that causes an incorrect order of lines in the
> debugfs log.
>
> Currently, the test counts lines that show the number of tests passed,
> failed, and skipped, as well as any suite diagnostic lines,
> appear prior to the individual results, which is a bug.
>
> Ensure the order of printing for the debugfs log is correct. Additionally,
> add a KTAP header to so the debugfs logs can be valid KTAP.
>
> This is an example of a log prior to these fixes:
>
>      KTAP version 1
>
>      # Subtest: kunit_status
>      1..2
>  # kunit_status: pass:2 fail:0 skip:0 total:2
>  # Totals: pass:2 fail:0 skip:0 total:2
>      ok 1 kunit_status_set_failure_test
>      ok 2 kunit_status_mark_skipped_test
>  ok 1 kunit_status
>
> Note the two lines with stats are out of order. This is the same debugfs
> log after the fixes (in combination with the third patch to remove the
> extra line):
>
>  KTAP version 1
>  1..1
>      KTAP version 1
>      # Subtest: kunit_status
>      1..2
>      ok 1 kunit_status_set_failure_test
>      ok 2 kunit_status_mark_skipped_test
>  # kunit_status: pass:2 fail:0 skip:0 total:2
>  # Totals: pass:2 fail:0 skip:0 total:2
>  ok 1 kunit_status
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes from v2 -> v3:
> - No changes.
>
> Changes from v1 -> v2:
> - Add KTAP header.
> - Ensure test result number is 1.
>
>  lib/kunit/debugfs.c | 14 ++++++++++++--
>  lib/kunit/test.c    | 21 ++++++++++++++-------
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index de0ee2e03ed6..b08bb1fba106 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -55,14 +55,24 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
>         enum kunit_status success = kunit_suite_has_succeeded(suite);
>         struct kunit_case *test_case;
>
> -       if (!suite || !suite->log)
> +       if (!suite)
>                 return 0;
>
> -       seq_printf(seq, "%s", suite->log);
> +       /* Print KTAP header so the debugfs log can be parsed as valid KTAP. */
> +       seq_puts(seq, "KTAP version 1\n");
> +       seq_puts(seq, "1..1\n");
> +
> +       /* Print suite header because it is not stored in the test logs. */
> +       seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> +       seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
> +       seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
>
>         kunit_suite_for_each_test_case(suite, test_case)
>                 debugfs_print_result(seq, suite, test_case);
>
> +       if (suite->log)
> +               seq_printf(seq, "%s", suite->log);
> +
>         seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
>         return 0;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c4d6304edd61..811fcc376d2f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -152,10 +152,18 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> +       /*
> +        * We do not log the test suite header as doing so would
> +        * mean debugfs display would consist of the test suite
> +        * header prior to individual test results.
> +        * Hence directly printk the suite status, and we will
> +        * separately seq_printf() the suite header for the debugfs
> +        * representation.
> +        */
> +       pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> +       pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
>                   suite->name);
> -       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> +       pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
>                   kunit_suite_num_test_cases(suite));
>  }
>
> @@ -172,10 +180,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>
>         /*
>          * We do not log the test suite results as doing so would
> -        * mean debugfs display would consist of the test suite
> -        * description and status prior to individual test results.
> -        * Hence directly printk the suite status, and we will
> -        * separately seq_printf() the suite status for the debugfs
> +        * mean debugfs display would consist of an incorrect test
> +        * number. Hence directly printk the suite result, and we will
> +        * separately seq_printf() the suite results for the debugfs
>          * representation.
>          */
>         if (suite)
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>

--000000000000f8d01405f65c78e8
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB0
OWkO0/1AGtq9aQbOvcYUGZtGWFcZVGY8zqcKag4LATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDgwNTA1MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAokqvVOCY4FhKt5yQvrNm
EAFtVhYR3JAW0rO74bISchIt93gPXlefbuxX6He0NO5MktBUfeR7BIvJBJ2RtiqKLEbcNoQo6WVr
uTX6NfQhYymlrSAsWn2XDL5+9KGgbjCU38rJHKsb+lnVxxfiBuDkqDAaezFZTlKTtHPjeS1mGbzy
xum4oza42uwZQkxtVM6cymdhoMnFtqWB8f8T/r0hrUmtELUdBzyBBUnFiC/RnWY3JuzGDzACAKv1
0csC/J3eiVms9gkFOZJZ/N2S+KWOJ6Vv627c870H/rsjL+2lQ9XkuQmA4tkGVHl6dWi5+r1QMwyS
mPXcr9UmNjxStKmYkQ==
--000000000000f8d01405f65c78e8--
