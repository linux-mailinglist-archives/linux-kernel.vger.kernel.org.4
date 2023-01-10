Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488F664EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjAJWTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjAJWTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:19:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D65D89C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:19:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u9so32429205ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t++LEV5UCWnXHVk6Ptvl/C+VPyJN6d2D+UqD6eck/aw=;
        b=AG8SoYQDkEHZHpka8kFZBkg/fP+ZSVHpghHGI3A3d4GJsP2wQVbp2LsRr7paKf6NLU
         HM5Ezhvpok0M2m3frgAdCzvSMgDSliqO0tf6205cjH80IUiI8FlB8fzhuYcyhM6ToxdR
         E+/Afck/Yaw3jf6uh2+7VDltYZVCYC1j1/SwMyEMm0wcaOVP9RdCKdz5Qhz+3Cl1K0gw
         rXXaYcMUOSz9o2PYeks5DDiiU0990Rt0OXYRz0Ox5VgKZ0y03mWR0pp9HrU2S8/zwnHD
         ORDA4ChX4qYJejJOuH+dPhQ9paYV/ga+j+EMwEgowyIDnrLfFTC3LAcoKi/NDE8h73mk
         Ygqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t++LEV5UCWnXHVk6Ptvl/C+VPyJN6d2D+UqD6eck/aw=;
        b=DOPRoAlWfLzT/4Wbp6wjSLWUUIgbooZkMp/4hl2Jw1xBpxCOr59tzug0M/g/x3Q88H
         noJlp5LKvcbgXtfnhmC9pyPbS4SrJbwAXb13r3KIHoC6S/NiRnFQK3AtGPQO6JDxkv5w
         qL1FBxgO99X4kGrK9ewg38Zwm950J5nNTZxMwkb8JVpE45sP7vYI5Y7zCwY94Hv4bgbs
         StzFFYViKEmFuTemb9EuaZGnHmsrZK7PB42tOlJ7la7lHkpdfWLS/RVClYQsBUxialcP
         fSL67OMFRbA8NadXDtA72K1slTUJU345lpdb/4wLHa0qPxfkCzsUyi5CCyYOdTIJODYf
         /H7A==
X-Gm-Message-State: AFqh2krlHoYGntXPg8gN+OK2QKfkPvNHAs+Q4i9D7clxfvRF0tqXPHbx
        du+eo3SmxGL/icj0SwI/ecIElllgwqQ4oOuPI5iRvw==
X-Google-Smtp-Source: AMrXdXuj5TLX+I+CqjyD0bfDBzpCTg2T4dSF/jfoETA4i6TYBJlDROL38EyCnCnq3iwpcEBvjEYVTKRrw7Nqn4lpZRg=
X-Received: by 2002:a17:907:91cd:b0:854:cd76:e982 with SMTP id
 h13-20020a17090791cd00b00854cd76e982mr450923ejz.364.1673389156374; Tue, 10
 Jan 2023 14:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20230110215203.4144627-1-vipinsh@google.com>
In-Reply-To: <20230110215203.4144627-1-vipinsh@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 10 Jan 2023 14:19:04 -0800
Message-ID: <CANgfPd8g+-QiNr-m4uS-=_baWwOT8gMvTedR-cDJud7_aWK-yQ@mail.gmail.com>
Subject: Re: [Patch] KVM: selftests: Make reclaim_period_ms input always be positive
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 1:52 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> reclaim_period_ms used to be positive only but the commit 0001725d0f9b
> ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> validation") incorrectly changed it to non-negative validation.
>
> Change validation to allow only positive input.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Reported-by: Ben Gardon <bgardon@google.com>

Please add a Fixes: tag:
Fixes: 0001725d0f9b ("KVM: selftests: Add atoi_positive() and
atoi_non_negative() for input validation")

But otherwise,
Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> index ea0978f22db8..251794f83719 100644
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> @@ -241,7 +241,7 @@ int main(int argc, char **argv)
>         while ((opt = getopt(argc, argv, "hp:t:r")) != -1) {
>                 switch (opt) {
>                 case 'p':
> -                       reclaim_period_ms = atoi_non_negative("Reclaim period", optarg);
> +                       reclaim_period_ms = atoi_positive("Reclaim period", optarg);
>                         break;
>                 case 't':
>                         token = atoi_paranoid(optarg);
> --
> 2.39.0.314.g84b9a713c41-goog
>
