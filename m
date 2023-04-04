Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5B6D5598
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDDAgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDAgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:36:31 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE2211B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:36:30 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id z17so20372604vsf.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680568590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7MLzQxwcJooCwdRyW+rvRjEc0Eh6fT3Q/Ld2FbVs9I=;
        b=Xd+hak6FTXQlgC2f1bCYW8sgyicJGxCunHbwO4DYPHaleyYNERcdic7v/9ZaMqoqYS
         hBisCVm18B94gRnWpISdHEPOe3YmqRov5q8204zLtTee18HRXnJ5nLRMzeIE3az2iw39
         VTUdH2ph9DwfpYvjmOGUjkamNMMHZ6cHVDLuhTlEGZoZQC1VqRez17/CjDcxJ1uHg42h
         Xdmf++AhVGA+I51HxD2Kz0911gmQ0JiIvMfpGP62QOV0dX2rTSM5DzN2prGIV9ubluk9
         nofrpcyhfCJSynG5vImk0VanwANNvIfuGdU34levneh1xY2orTfp/MPOYk9cv3I0kCCi
         E5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7MLzQxwcJooCwdRyW+rvRjEc0Eh6fT3Q/Ld2FbVs9I=;
        b=Nb6OOJclv9KDwNbTbkbLH/MBazWdhE1UHXAzcbsSTVt9OiDgiKG4DvESzOoDQ21hJg
         yZJe9OprT0eDu/0QGoz26PHEtKEgAtZ57KOLdgT5NKRfAwyADCq39T5btTws7Jkc4I1+
         aMhSM5Fdc7smjpF8v9Ccn+alz4NasR/fv3BNOi/zJwcGI5lijMIyqH8q+SjZqpAAriUq
         bJV8CEIRhgA1CZF5pmDUNrY06t+tfJwWvSScVXHUaC7xCtbXyXr8+ugeHheF0Ax2DJK1
         DqbwlGGFe9SYAlJlSkRKz5EAtJs6zWatPGvoJ3DSJ6twNB8vgaJCAsLrWS6vchGXgJaK
         qr3Q==
X-Gm-Message-State: AAQBX9ey2K4PXRDtD1tKsH2BE6USTkxkF6EUeyZPgu6oFqcrhnJjGTgg
        EGOdRlC6AY3Rdbeq/ztOPju/3S29NfJPBJkDhMhLGQ==
X-Google-Smtp-Source: AKy350as7KBp25BikdlFmQDfe7ySOC1FAeNUgcQle0FSKFkpQzxD1F7NFpNRluz9nxqx4mbiytS6m/2gxFaKSnmMkYQ=
X-Received: by 2002:a67:d901:0:b0:422:194a:8566 with SMTP id
 t1-20020a67d901000000b00422194a8566mr992320vsj.5.1680568589910; Mon, 03 Apr
 2023 17:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230403201930.2019419-1-rmoar@google.com>
In-Reply-To: <20230403201930.2019419-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Apr 2023 08:36:17 +0800
Message-ID: <CABVgOSkjmsyi3nMtMkEf3M076mLgmSUrLXUVtvWLcESE7NnVRw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: add tests for using current KUnit test field
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d7eefc05f877dd20"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d7eefc05f877dd20
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Apr 2023 at 04:19, Rae Moar <rmoar@google.com> wrote:
>
> Create test suite called "kunit_current" to add test coverage for the use
> of current->kunit_test, which returns the current KUnit test.
>
> Add two test cases:
> - kunit_current_test to test current->kunit_test and the method
>   kunit_get_current_test(), which utilizes current->kunit_test.
>
> - kunit_current_fail_test to test the method
>   kunit_fail_current_test(), which utilizes current->kunit_test.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes from v1->v2:
> - Combine two test cases to test both ways of getting current test in
>   kunit_current_test.
> - Changes to comments.
> - Add kunit_cleanup to kunit_current_fail_test.
>
>  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index b63595d3e241..42e44caa1bdd 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -6,6 +6,7 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>
>  #include "try-catch-impl.h"
>
> @@ -532,7 +533,46 @@ static struct kunit_suite kunit_status_test_suite = {
>         .test_cases = kunit_status_test_cases,
>  };
>
> +static void kunit_current_test(struct kunit *test)
> +{
> +       /* Check results of both current->kunit_test and
> +        * kunit_get_current_test() are equivalent to current test.
> +        */
> +       KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
> +       KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
> +}
> +
> +static void kunit_current_fail_test(struct kunit *test)
> +{
> +       struct kunit fake;
> +
> +       kunit_init_test(&fake, "fake test", NULL);
> +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> +
> +       /* Set current->kunit_test to fake test. */
> +       current->kunit_test = &fake;
> +
> +       kunit_fail_current_test("This should make `fake` test fail.");
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
> +       kunit_cleanup(&fake);
> +
> +       /* Reset current->kunit_test to current test. */
> +       current->kunit_test = test;
> +}
> +
> +static struct kunit_case kunit_current_test_cases[] = {
> +       KUNIT_CASE(kunit_current_test),
> +       KUNIT_CASE(kunit_current_fail_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_current_test_suite = {
> +       .name = "kunit_current",
> +       .test_cases = kunit_current_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> -                 &kunit_log_test_suite, &kunit_status_test_suite);
> +                 &kunit_log_test_suite, &kunit_status_test_suite,
> +                 &kunit_current_test_suite);
>
>  MODULE_LICENSE("GPL v2");
>
> base-commit: 7232282dd47cce6a780c9414bd9baccf232c7686
> --
> 2.40.0.348.gf938b09366-goog
>

--000000000000d7eefc05f877dd20
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCg
xcee6FhFj9C3kECcC1at7mMOtrDNDfx5TS6P0iWMUjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDQwMDM2MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAutEOvscrZaHda2EwZv4m
889lRWvK/u0od+YjFUna7uDQMDiH6sfTiqc9jsPB5C/c9hMEW/s7Kpq2h36d5X2T/pNQlEN0hBG0
PBDi/fOEZLmmKACsDbIkLLtVE93XqHXKUdVuLOOFOKP7SY0VBJ+H5jFi6yB7F7zgjU+5y2/kq0Aw
lD5cZiKbG4acdrzzsAVbbE2mtXF+2WUyN/ZvPvhh/PhFGrIvDnYUCvRlvA3w9Mi5xiL2WN2+gAHi
L96BeI940/yDYzo9+GAHMgqGtooEGpsg1eAll30ry5AAfEUnuaAQRcZOkIFY7FGXKAcfUiXTDK1C
wLrslNw9/c5Flrv3OQ==
--000000000000d7eefc05f877dd20--
