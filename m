Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4E6C03AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCSSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A250EF96;
        Sun, 19 Mar 2023 11:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E7B61147;
        Sun, 19 Mar 2023 18:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C19C433EF;
        Sun, 19 Mar 2023 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679249010;
        bh=BCR9y/blX60wK/FGu309K2AvT0ognRG1hDhtrsXgIys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mc5/47gf+hmhlPYKGNOAiW2K8UVDizr+OXCpEk+ojTyg4DBIw5Eo8Qme9+cdnoMI5
         UKTOx+3EVZ4nFjQCj73VgdCaG1Di2UAD2ls4iaq/52R74tBrLo3LupznJkzyKrscdm
         4UWNNep0a87ijrvZ34Rp6WGc8lp/ZS18Ll1uxsmQFtYb29uDoqTwLdr+nuFe03o3gO
         c2wyuUis4RWzERZw3f/eLVBgYsdCROmDqFeDtD80PZvpkag3bU38d2ovS7yNI3PQyv
         uWteRGhOz1VmpyK8vJOuaIdzZiz4rolmzIO4naEhvpCw0k4DydMERyGuwOzxwv8xLH
         rTLuzEBA19eWQ==
Date:   Sun, 19 Mar 2023 18:18:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/8] iio: test: test gain-time-scale helpers
Message-ID: <20230319181824.59255b23@jic23-huawei>
In-Reply-To: <31cf5765078b2d808d9e66eb623cde70ee6478ac.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
        <31cf5765078b2d808d9e66eb623cde70ee6478ac.1679062529.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 16:43:49 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> Hence some gain-time-scale helpers were introduced.
> 
> Add some simple tests to verify the most hairy functions.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

A few comments inline.

As mentioned in previous patch I wonder if you should get rid
of the separation between init and build_tables code. That would require
always building tables in here even when you don't use them, but that may
be a sensible choice as drivers would never expect to not build the tables
anyway (I think).

Jonathan

> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 0b6e4e278a2f..4d5cfb9fe60b 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -4,6 +4,20 @@
>  #
>  
>  # Keep in alphabetical order
> +config IIO_GTS_KUNIT_TEST
> +	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	select IIO_GTS_HELPER
> +	select TEST_KUNIT_DEVICE_HELPERS
> +	default KUNIT_ALL_TESTS
> +	help
> +	  build unit tests for the IIO light sensor gain-time-scale helpers.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N. Keep in alphabetical order
> +
>  config IIO_RESCALE_KUNIT_TEST
>  	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
>  	depends on KUNIT && IIO_RESCALE
> @@ -27,3 +41,5 @@ config IIO_FORMAT_KUNIT_TEST
>  	  to the KUnit documentation in Documentation/dev-tools/kunit/.
>  
>  	  If unsure, say N.
> +
> +

Several stray blank lines that shouldn't be in here.

> diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gts.c
> new file mode 100644
> index 000000000000..ff9311acd0bb
> --- /dev/null
> +++ b/drivers/iio/test/iio-test-gts.c
> @@ -0,0 +1,461 @@

...


> +static int test_init_iio_gain_scale(struct iio_gts *gts, int max_scale_int,
> +				int max_scale_nano)
> +{
> +	int ret;
> +
> +	ret = iio_init_iio_gts(max_scale_int, max_scale_nano, gts_test_gains,
> +			       ARRAY_SIZE(gts_test_gains), gts_test_itimes,
> +			       ARRAY_SIZE(gts_test_itimes), gts);

	return iio_init...

Or get rid of this wrapper entirely.

> +
> +	return ret;
> +}
> +

> +
> +static void test_iio_gts_avail_test(struct kunit *test)
> +{
> +	struct iio_gts gts;
> +	int ret;
> +	int type, len;
> +	const int *vals;
> +	struct device *dev;
> +
> +	ret = test_init_iio_gain_scale(&gts, TEST_SCALE_1X, 0);

I don't follow why the wrapper is useful here.  Why not just call it
directly and have the arrays passed in nice and obvious here.

> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	if (ret)
> +		return;
> +
> +	dev = test_kunit_helper_alloc_device(test);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
> +	if (!dev)
> +		return;
> +
> +	ret = devm_iio_gts_build_avail_tables(dev, &gts);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	if (ret)
> +		goto drop_testdev;
> +
> +	/* test table building for times and iio_gts_avail_times() */
> +	ret = iio_gts_avail_times(&gts, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		goto drop_testdev;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT, type);
> +	KUNIT_EXPECT_EQ(test, 4, len);
> +	if (len < 4)
> +		goto drop_testdev;
> +
> +	test_iio_gts_chk_times(test, vals);
> +
> +	/* Test table building for all scales and iio_gts_all_avail_scales() */
> +	ret = iio_gts_all_avail_scales(&gts, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		goto drop_testdev;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
> +
> +	test_iio_gts_chk_scales_all(test, &gts, vals, len);
> +
> +	/*
> +	 * Test table building for scales/time and
> +	 * iio_gts_avail_scales_for_time()
> +	 */
> +	ret = iio_gts_avail_scales_for_time(&gts, 200000, &vals, &type, &len);
> +	KUNIT_EXPECT_EQ(test, IIO_AVAIL_LIST, ret);
> +	if (ret)
> +		goto drop_testdev;
> +
> +	KUNIT_EXPECT_EQ(test, IIO_VAL_INT_PLUS_NANO, type);
> +	test_iio_gts_chk_scales_t200(test, &gts, vals, len);
> +
> +drop_testdev:
> +	test_kunit_helper_free_device(test, dev);
> +}
> +
> +static struct kunit_case iio_gts_test_cases[] = {
> +		KUNIT_CASE(test_iio_gts_find_gain_for_scale_using_time),
> +		KUNIT_CASE(test_iio_gts_find_new_gain_sel_by_old_gain_time),
> +		KUNIT_CASE(test_iio_find_closest_gain_low),
> +		KUNIT_CASE(test_iio_gts_total_gain_to_scale),
> +		KUNIT_CASE(test_iio_gts_avail_test),
> +		{}
> +};
> +
> +static struct kunit_suite iio_gts_test_suite = {
> +	.name = "iio-gain-time-scale",
> +	.test_cases = iio_gts_test_cases,
> +};
> +
> +kunit_test_suite(iio_gts_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_DESCRIPTION("Test IIO light sensor gain-time-scale helpers");
> +MODULE_IMPORT_NS(IIO_GTS_HELPER);
> +
Looks like a stray blank line at end of file.


