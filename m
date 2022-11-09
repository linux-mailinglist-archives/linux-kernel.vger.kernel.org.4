Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05786227B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKIJ4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Nov 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiKIJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:55:49 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 01:55:48 PST
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1BD02529D;
        Wed,  9 Nov 2022 01:55:48 -0800 (PST)
Received: from smtpclient.apple (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 7EED31A21FD2;
        Wed,  9 Nov 2022 11:39:29 +0200 (EET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
Date:   Wed, 9 Nov 2022 11:39:14 +0200
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz
Content-Transfer-Encoding: 8BIT
Message-Id: <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

> 9 лист. 2022 р. о 10:48 Wang Yufen <wangyufen@huawei.com> написав(ла):
> 
> When non-devm resources are allocated they mustn't be followed by devm
> allocations, otherwise it will break the tear down ordering and might
> lead to crashes or other bugs during ->remove() stage. Fix this by
> wrapping mutex_destroy() call with devm_add_action_or_reset().
> 
> Fixes: fc19967bcb8f ("leds: add LED driver for EL15203000 board")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> ---
> drivers/leds/leds-el15203000.c | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
> index 7e7b617..9be934e 100644
> --- a/drivers/leds/leds-el15203000.c
> +++ b/drivers/leds/leds-el15203000.c
> @@ -287,10 +287,16 @@ static int el15203000_probe_dt(struct el15203000 *priv)
> return ret;
> }
> 
> +static void el15203000_mutex_destroy(void *lock)
> +{
> + mutex_destroy(lock);
> +}
> +
> static int el15203000_probe(struct spi_device *spi)
> {
> struct el15203000 *priv;
> size_t count;
> + int ret;
> 
> count = device_get_child_node_count(&spi->dev);
> if (!count) {
> @@ -312,15 +318,14 @@ static int el15203000_probe(struct spi_device *spi)
> 
> spi_set_drvdata(spi, priv);
> 
> + ret = devm_add_action_or_reset(&spi->dev, el15203000_mutex_destroy,
> +       &priv->lock);
> + if (ret)
> + return ret;
> +
> return el15203000_probe_dt(priv);
> }
> 
> -static void el15203000_remove(struct spi_device *spi)

Is remove() callback from struct spi_driver deprecated?

> -{
> - struct el15203000 *priv = spi_get_drvdata(spi);
> -
> - mutex_destroy(&priv->lock);
> -}
> 
> static const struct of_device_id el15203000_dt_ids[] = {
> { .compatible = "crane,el15203000", },
> @@ -331,7 +336,6 @@ static void el15203000_remove(struct spi_device *spi)
> 
> static struct spi_driver el15203000_driver = {
> .probe = el15203000_probe,
> - .remove = el15203000_remove,
> .driver = {
> .name = KBUILD_MODNAME,
> .of_match_table = el15203000_dt_ids,
> -- 
> 1.8.3.1
> 

