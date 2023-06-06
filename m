Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79ED724483
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbjFFNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFFNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930790;
        Tue,  6 Jun 2023 06:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D210262CBA;
        Tue,  6 Jun 2023 13:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F9BC433EF;
        Tue,  6 Jun 2023 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686058452;
        bh=5Wa3NdRhxMUFgQP78FKERj+NR5d7foRPY13O9oAOibk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UAytinUDjtG1t2fEbPmz0weYmijL4douyQcXVVmTjV0JCXKP7GJ6lU9YRCvJ2rzxF
         LaqgytdnAW7BB4AR3ZvCYMUPCKYoSu+VkqCk5grTkjAcQXWV0LWvHc4LaQ3mT8oOYn
         s54pnAMm6oGUvs5cOQF0DMKnPVwADd2hc7KKNb43RASwr3006DOYUGXjct0f/dlFIy
         jopU5apHdiddr5w2x8o6HJRMFZkv7bHvvv9x+ICVpgnMCIdePLX+J6ECMbowqctnmD
         YZJluHfOBNO30/16jbgqJ+kSbhoXrBvF4VYAg6HWAOhxzTkxHh70PZlGJZ94vz/Oxn
         O1ZJRSzcYPuEQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/realtek/rtw88/mac.c:748 __rtw_download_firmware() warn: missing unwind goto?
References: <291c3208-39c1-4eb5-bbca-b1331c346782@kadam.mountain>
Date:   Tue, 06 Jun 2023 16:34:06 +0300
In-Reply-To: <291c3208-39c1-4eb5-bbca-b1331c346782@kadam.mountain> (Dan
        Carpenter's message of "Tue, 6 Jun 2023 08:34:57 +0300")
Message-ID: <87r0qoiuk1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-wireless, top posting so that the whole report is included.

Dan Carpenter <dan.carpenter@linaro.org> writes:

> Hi Sascha,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9561de3a55bed6bdd44a12820ba81ec416e705a7
> commit: 45794099f5e1d7abc5eb07e6eec7e1e5c6cb540d wifi: rtw88: Add
> rtw8822bu chipset support
> config: riscv-randconfig-m031-20230605
> (https://download.01.org/0day-ci/archive/20230605/202306052310.OVhcUjZ3-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202306052310.OVhcUjZ3-lkp@intel.com/
>
> smatch warnings:
> drivers/net/wireless/realtek/rtw88/mac.c:748 __rtw_download_firmware()
> warn: missing unwind goto?
>
> vim +748 drivers/net/wireless/realtek/rtw88/mac.c
>
> 3d8bf50860c7de Yan-Hsuan Chuang 2020-04-24 717 static int
> __rtw_download_firmware(struct rtw_dev *rtwdev,
> 3d8bf50860c7de Yan-Hsuan Chuang 2020-04-24 718 struct rtw_fw_state
> *fw)
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  719  {
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 720 struct rtw_backup_info
> bckp[DLFW_RESTORE_REG_NUM];
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 721 const u8 *data =
> fw->firmware->data;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  722  	u32 size = fw->firmware->size;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  723  	u32 ltecoex_bckp;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  724  	int ret;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  725  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 726 if
> (!check_firmware_size(data, size))
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  727  		return -EINVAL;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  728  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 729 if
> (!ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  730  		return -EBUSY;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  731  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 732 wlan_cpu_enable(rtwdev,
> false);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  733  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 734
> download_firmware_reg_backup(rtwdev, bckp);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 735
> download_firmware_reset_platform(rtwdev);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  736  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 737 ret =
> start_download_firmware(rtwdev, data, size);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  738  	if (ret)
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  739  		goto dlfw_fail;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  740  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 741
> download_firmware_reg_restore(rtwdev, bckp, DLFW_RESTORE_REG_NUM);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  742  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 743
> download_firmware_end_flow(rtwdev);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  744  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  745  	wlan_cpu_enable(rtwdev, true);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  746  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 747 if
> (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp))
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 @748  		return -EBUSY;
>
> All the other error paths goto dlfw_fail;
>
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  749  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 750 ret =
> download_firmware_validate(rtwdev);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  751  	if (ret)
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  752  		goto dlfw_fail;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  753  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  754  	/* reset desc and index */
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  755  	rtw_hci_setup(rtwdev);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  756  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  757  	rtwdev->h2c.last_box_num = 0;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  758  	rtwdev->h2c.seq = 0;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  759  
> 3c519605850890 Yan-Hsuan Chuang 2019-10-02 760
> set_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  761  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  762  	return 0;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  763  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  764  dlfw_fail:
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  765  	/* Disable FWDL_EN */
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 766 rtw_write8_clr(rtwdev,
> REG_MCUFW_CTRL, BIT_MCUFWDL_EN);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 767 rtw_write8_set(rtwdev,
> REG_SYS_FUNC_EN + 1, BIT_FEN_CPUEN);
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  768  
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  769  	return ret;
> e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  770  }

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
