Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD65EF51C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiI2MTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiI2MTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F5147F30;
        Thu, 29 Sep 2022 05:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44B26113D;
        Thu, 29 Sep 2022 12:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B96DC433D7;
        Thu, 29 Sep 2022 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664453937;
        bh=gKdjwVsfsr4wCSJDA0zSaFv6ty+qQPz23x9GYNS0JRg=;
        h=From:To:Cc:Subject:Date:From;
        b=vAsVlZCsejM8/zUcf2vDobM0Xuax/zsy3ecI/C/EEnhLg4bwSRk7lXfqzw71lVji6
         SpHG2a8itzakRAOGNon0byYG5IyrAaJDVOIe/NTlH/ihyzH03Yn4ZyyEyFwrNdHPZs
         Fr0ta02/qgx6NWRj1OV/NhmvMLjfoV/J9jSboGf3vT43JgUJcI5LMlYVmTmriwbosK
         gAFuvR8m6ANh/CyfbH7yZA+r2gH5lYu+JAxImyaah3lNKxKGsruANDuKkEA0Uy4LBo
         Ww8ikqoMh427H9zH7fW/v4n9VM5stZefr/X1EaGDworTFtkw/NwqCjAdh5MAcx/fsh
         vK7r3hu+TMIlw==
From:   broonie@kernel.org
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the pm tree with the i2c tree
Date:   Thu, 29 Sep 2022 13:18:53 +0100
Message-Id: <20220929121853.100271-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  drivers/platform/x86/intel/int3472/tps68470.c

between commit:

  ed5c2f5fd10dd ("i2c: Make remove callback return void")

from the i2c tree and commit:

  06a659d1f0a0a ("platform/x86: int3472: Support multiple gpio lookups in board data")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/platform/x86/intel/int3472/tps68470.c
index 5dd81bb05255b,49fc379fe680a..0000000000000
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@@ -178,13 -227,18 +227,16 @@@ static int skl_int3472_tps68470_probe(s
  	return ret;
  }
  
 -static int skl_int3472_tps68470_remove(struct i2c_client *client)
 +static void skl_int3472_tps68470_remove(struct i2c_client *client)
  {
  	const struct int3472_tps68470_board_data *board_data;
+ 	int i;
  
  	board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
- 	if (board_data)
- 		gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
+ 	if (board_data) {
+ 		for (i = 0; i < board_data->n_gpiod_lookups; i++)
+ 			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
+ 	}
 -
 -	return 0;
  }
  
  static const struct acpi_device_id int3472_device_id[] = {
