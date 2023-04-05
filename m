Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81FC6D75D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjDEHt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjDEHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:49:24 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231785246
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:49:12 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id g17so30646957vst.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680680951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4DVRLfjfCY64q6RtpvGO8Y6jQWRXpPTxnST3vHxBK2A=;
        b=QlLlVDv40JkUrB1nJjBhEPPl/u9S2oJJisrieKEe0LB4ix81fPoK5Uv1jdh7b61ra1
         6I3cQ5lg5OnWATs7lyOOKb4hAM788xW2mEXXgQKloyob5Z9ss5N8S8+feHFekulb9Ii1
         00I9y50wHwi0yiQybPBiKg2MQBHVk/tf4aG3ZV0C+mIMxtChfNFNRahGOciGRWRJe8Hy
         nytanLCwTIQmSNUPV+u5l3xM4WpRKgPSR6kxnx7IPXh7YgM6rfJFrkRzXXtZ+vrysrN2
         bBsi+eHjHX3O6p6UqQpuLLuplHtrE/10DVXAE+IqKBic7MCiSD20a/vDH04wBh/mn5qt
         uDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DVRLfjfCY64q6RtpvGO8Y6jQWRXpPTxnST3vHxBK2A=;
        b=vCaS/1okReskrKUaY5jpMdSrMQUs7Ud5+zWcDEbr2ASwsmzhzakQXofdrR2IhFYyk8
         KerxBMuZjXzB/64plCjM3lrQ8rlkcRbdTv8hwtQl4zhW7EKmhgekUFfaEo32guL25Rvf
         m5Gu/SDNL9gEMZ+WERoi9o9gDVo/eSrM4LNdmq2hcoLMSrKIR3v3i9RiYaUmxlBKgZC5
         BopGYcnjdQQY+G5WkhGtm6PbG+pM9eE/n7NHmZtPapmYk6nleiWWHXkQGEguvK5W8IJH
         kngBThz+2CUnAt77N2tJM5NWkTcHfS7NNoirUYjeWrzWlV8Amxw01+HKw2jM5jGyWXNw
         ZIow==
X-Gm-Message-State: AAQBX9dDw4xQTL6pb+3O1NoiFo+zTEl65a12KWiiKu44H5nvq1DtgLg8
        z4nXI3W+TbT4ZOxO3yUiLQOoeO1marC4goZJRVXzdA==
X-Google-Smtp-Source: AKy350Y3fu50GAY8VhIcqjZjxjMjY7rPK9avRDK5KiWHq2ipoNGHNRqNYSciI8EFDYY5sW3vLA0+Lg2hkjSQTbiHw50=
X-Received: by 2002:a67:c20a:0:b0:416:f1ea:1001 with SMTP id
 i10-20020a67c20a000000b00416f1ea1001mr4135532vsj.5.1680680950913; Wed, 05 Apr
 2023 00:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com> <20230331080411.981038-4-davidgow@google.com>
 <fbfaed01ac773b72a5a79f9a514c646ac21d5583.camel@sipsolutions.net>
In-Reply-To: <fbfaed01ac773b72a5a79f9a514c646ac21d5583.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 Apr 2023 15:48:59 +0800
Message-ID: <CABVgOSm+9t6araJTUDeX88X1e8+kDUTvELQ2mLCBYHBgUx5Q1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] kunit: kmalloc_array: Use kunit_add_action()
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001458ba05f89207f1"
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

--0000000000001458ba05f89207f1
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Apr 2023 at 01:59, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> Hi,
>
> On Fri, 2023-03-31 at 16:04 +0800, 'David Gow' via KUnit Development wrote:
> > The kunit_add_action() function is much simpler and cleaner to use that
> > the full KUnit resource API for simple things like the
> > kunit_kmalloc_array() functionality.
> >
> > Replacing it allows us to get rid of a number of helper functions, and
> > leaves us with no uses of kunit_alloc_resource(), which has some
> > usability problems and is going to have its behaviour modified in an
> > upcoming patch.
> >
> > Note that we need to use kunit_defer_trigger_all() to implement
> > kunit_kfree().
>
> Just a nitpick: kunit_defer_trigger_all does not exist in the new patch
> anymore. I guess this should be kunit_release_action.
>
> Benjamin
>

Nice catch, thanks! I'll fix it in the next revision.

Cheers,
-- David



-- David

> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/kunit/test.c | 48 ++++++++----------------------------------------
> >  1 file changed, 8 insertions(+), 40 deletions(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index e2910b261112..ec45c8863f04 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -712,58 +712,26 @@ static struct notifier_block kunit_mod_nb = {
> >  };
> >  #endif
> >
> > -struct kunit_kmalloc_array_params {
> > -       size_t n;
> > -       size_t size;
> > -       gfp_t gfp;
> > -};
> > -
> > -static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
> > +void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
> >  {
> > -       struct kunit_kmalloc_array_params *params = context;
> > -
> > -       res->data = kmalloc_array(params->n, params->size, params->gfp);
> > -       if (!res->data)
> > -               return -ENOMEM;
> > -
> > -       return 0;
> > -}
> > +       void *data;
> >
> > -static void kunit_kmalloc_array_free(struct kunit_resource *res)
> > -{
> > -       kfree(res->data);
> > -}
> > +       data = kmalloc_array(n, size, gfp);
> >
> > -void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
> > -{
> > -       struct kunit_kmalloc_array_params params = {
> > -               .size = size,
> > -               .n = n,
> > -               .gfp = gfp
> > -       };
> > +       if (!data)
> > +               return NULL;
> >
> > -       return kunit_alloc_resource(test,
> > -                                   kunit_kmalloc_array_init,
> > -                                   kunit_kmalloc_array_free,
> > -                                   gfp,
> > -                                   &params);
> > +       kunit_add_action(test, (kunit_defer_function_t)kfree, data, gfp);
> > +       return data;
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
> >
> > -static inline bool kunit_kfree_match(struct kunit *test,
> > -                                    struct kunit_resource *res, void *match_data)
> > -{
> > -       /* Only match resources allocated with kunit_kmalloc() and friends. */
> > -       return res->free == kunit_kmalloc_array_free && res->data == match_data;
> > -}
> > -
> >  void kunit_kfree(struct kunit *test, const void *ptr)
> >  {
> >         if (!ptr)
> >                 return;
> >
> > -       if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
> > -               KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
> > +       kunit_release_action(test, (kunit_defer_function_t)kfree, (void *)ptr);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_kfree);
> >
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>

--0000000000001458ba05f89207f1
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAq
LMr36Lqu+sgs0qDCK/eVgwIIQlMSZbscvqAY5dCQtDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDUwNzQ5MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAizqry5m/4WXqxp8SlEzR
EtjcEc04vPoroMDtFTtKUmu+IByPQdHueFS/FGfiRP8Ri5XlrOqqyFNEjWKMhB5Lvt8wKtL27H1U
aempqhR3o/Jiwkr8hN8wFoSIUSzqqP6cEWrGBEnC9XvUPcFg8SEVEsW5ukNDm/DMNRB9T4bLJn7a
Vk3/j99iJxao5QzdxGSWiqAjUz68NwAT3xyfT4NtGsr65Y5T6EMUe1q81OCVtqy8Yk/vYvPeNxN8
j2mMpkHkd8APTZqnw2ehCVqGUF5WvWzqo/aacPsXkfIPBN1zAN7NnU6vHx44slVtWV+BvLXFLcNH
Oox1BWkaqaazVh5rTA==
--0000000000001458ba05f89207f1--
