Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29393738EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFUSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFUSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:33:30 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D81730
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:33:28 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QmXFN1CPqzDqQZ;
        Wed, 21 Jun 2023 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1687372408; bh=Ygwht59UeqNC4HljDIALvqvdMres18Xj0eWA0Ceti/E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QRmaLiP+7k8UnTYaFtcjZWg+5IjsJwfrZaq57/41RqWzI0rY1BCa4CbR39STBJ0dW
         XV149DwHulvGHbVMDT7qaAshwtU5dZZp+WUteLN1dBrs0M4XXy4IpEEwZtN3uB1aSN
         J/oMtLISzw/rA76jlCr/lV9CJjsy3IEuqLmHKlB4=
X-Riseup-User-ID: 7D49E1C82EA2BFED9008EFF8AAC5C3150B648584A3E60BEC1C72C39F2BA3C13D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QmXFL3xTRzJntM;
        Wed, 21 Jun 2023 18:33:26 +0000 (UTC)
Message-ID: <d813dbe5-4d9a-94d2-22f2-b480f68a8f6f@riseup.net>
Date:   Wed, 21 Jun 2023 15:33:24 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/tests: Add test case for drm_rect_clip_scaled()
Content-Language: en-US
To:     nelsonbogado99 <nelosonbrizue99@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>
References: <20230614175431.6496-1-nelosonbrizue99@gmail.com>
From:   Arthur Grillo Queiroz Cabral <arthurgrillo@riseup.net>
In-Reply-To: <20230614175431.6496-1-nelosonbrizue99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/23 14:54, nelsonbogado99 wrote:
> From: Nelson Bogado <nelosonbrizue99@gmail.com>
> 
> To evaluate the behavior of the drm_rect_clip_scaled() helper function
> with misplaced rectangles and improve the robustness and quality of it.
> 
> The new test was executed using the following command:
> 
>   $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests/
>   [01:48:12] ================== drm_rect (10 subtests) ==================
>   ...
>   [01:48:12] [PASSED] drm_test_rect_clip_scaled_out_of_bounds
> 
> Signed-off-by: Nelson Bogado <nelosonbrizue99@gmail.com>
> ---
>  drivers/gpu/drm/tests/drm_rect_test.c | 53 +++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
Hello,

here are a couple of suggestions to make the code more readable ;).

> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 76332cd2ead8..b3bfdd420123 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -209,6 +209,58 @@ static void drm_test_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
>  	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
>  }
>  
> +static void drm_test_rect_clip_scaled_out_of_bounds(struct kunit *test)
> +{
> +	/* Definition of the rectangles and visible variables */
I think it would be great to decrease the amount of comments, you don't need
to comment that you're declaring some variable. Maybe just keep the comments
that explain what you're testing

> +	struct drm_rect src, dst, clip;
> +	bool visible;
> +
> +	/*
> +	 * Both rectangles are completely out of bounds, initialize the src,
> +	 * dst and clip rectangles with specific coordinates and sizes.
> +	 */
like this one.

> +	drm_rect_init(&src, -10, -10, -5, -5);
> +	drm_rect_init(&dst, -20, -20, -15, -15);
> +	drm_rect_init(&clip, 0, 0, 100, 100);
> +
> +	/* Function call drm_rect_clip_scaled to determine visibility */
> +	visible = drm_rect_clip_scaled(&src, &dst, &clip);
> +
> +	/* Check expected results */
> +	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
> +	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
> +
> +	/*
> +	 * Only source rectangle is out of bounds, reinitialize the src,
> +	 * dst and clip rectangles with new values.
> +	 */
> +	drm_rect_init(&src, -10, -10, -5, -5);
Use `DRM_RECT_INIT` instead, this way you don't need to pass the variable as an
argument. I think it would be more readable.

~Arthur Grillo

> +	drm_rect_init(&dst, 0, 0, 10, 10);
> +	drm_rect_init(&clip, 0, 0, 100, 100);
> +
> +	/* Function call drm_rect_clip_scaled to determine visibility */
> +	visible = drm_rect_clip_scaled(&src, &dst, &clip);
> +
> +	/* Check expected results */
> +	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n\n");
> +	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
> +
> +	/*
> +	 * Only source rectangle is out of bounds, reinitialize the src,
> +	 * dst and clip rectangles with new values.
> +	 */
> +	drm_rect_init(&src, 0, 0, 10, 10);
> +	drm_rect_init(&dst, -10, -10, -5, -5);
> +	drm_rect_init(&clip, 0, 0, 100, 100);
> +
> +	/* Function call drm_rect_clip_scaled to determine visibility */
> +	visible = drm_rect_clip_scaled(&src, &dst, &clip);
> +
> +	/* Check expected results */
> +	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
> +	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
> +}
> +
>  struct drm_rect_intersect_case {
>  	const char *description;
>  	struct drm_rect r1, r2;
> @@ -511,6 +563,7 @@ static struct kunit_case drm_rect_tests[] = {
>  	KUNIT_CASE(drm_test_rect_clip_scaled_not_clipped),
>  	KUNIT_CASE(drm_test_rect_clip_scaled_clipped),
>  	KUNIT_CASE(drm_test_rect_clip_scaled_signed_vs_unsigned),
> +	KUNIT_CASE(drm_test_rect_clip_scaled_out_of_bounds),
>  	KUNIT_CASE_PARAM(drm_test_rect_intersect, drm_rect_intersect_gen_params),
>  	KUNIT_CASE_PARAM(drm_test_rect_calc_hscale, drm_rect_scale_gen_params),
>  	KUNIT_CASE_PARAM(drm_test_rect_calc_vscale, drm_rect_scale_gen_params),
