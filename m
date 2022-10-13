Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADB5FD490
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJMGNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJMGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:13:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2113D73
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665641619; x=1697177619;
  h=message-id:date:mime-version:subject:cc:references:from:
   to:in-reply-to:content-transfer-encoding;
  bh=zJgjNEVAuYaGMQ6lYH0Bn1yiH1iSfy1pag8xbODnifE=;
  b=hh4PJd4rPS0znwB/VoMn/sSZ4im1ueognUX+5a2BxFMlxlizejCukvyp
   3gFt13/Ym31S/M7tBXsQ9327Z3pV3oDceybD8dVkIp1pz6UtiRSd6N+cy
   KBPAJcT6qdL6XWsbEsnSGcyyxVqahTnAFBEwyqLJeI7EhRsshAXAK56OV
   EITALqGRo8/xoqL4nJKS89x41RY5nqJaetN4tmvOPvMEPb454QTW2KGpC
   HLsgwh9yqRUjtDOQyIB4B/2xa6c8NpDl+rUFfFur4mveQ7EAib3np2PxA
   aZOOZ0cUXdCv4LgL7YWrkXneflunL0W3t+6E5El45kMexNGs7Cgv4DR43
   g==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="212008772"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 14:13:37 +0800
IronPort-SDR: gTI5sHgd5tfN8GBP3zi+RYsGbE8ipwn1c3NSyPwAQKvTGiyoKmwwFAMyQ5KIyabIUINyszea3c
 d3pxhIOtM7YzAoXHOniFNCxBOYqJk7/WC4UGNFHn+0MrBcwv4hy3Y2GkNgXcNMNpWMmuyNUtze
 Kmfi1/lRNCejJ/rouEx4eM2j+Zh27q5jIG8RW44oiv/7bBEpWMKf7OMA9gWxHxDLf/LEhp9D71
 S8LZ5zmrZ/u6yce6aJJzXvfYtBSF3zcVm8bJ6jK19V0X6SM9rfB0UYe1b7ou/qxP+bYpt6oZgn
 9gc3kT1hN7is5x2bg/3DFKjW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 22:33:15 -0700
IronPort-SDR: inpZlq9qisE0pnF3NKfI0ef2JxOZONAJEif+v/5lNWKoIEnSGObI58zh9f1a0qJ1KjMlM7+2lz
 nOvz/oHPHrPZn1KiBhBuINx3Fjrnmehzi+XUA99SrQqzIwzn1AT8pap3/uoRzFNn9RrbMHDjKY
 lv/EkURWEfGY8fWwnTaEVVQczhsUNdMuy8kfT7zmpujrXkhNaqDD6gP+3fmrgpAytu7ojnIZgV
 3Rzt7c602eVjADiQ9VnbXawU9LtFWpZPPid97QjKcWXBMZksh8UMsQYqLUQoqyIAP6qx4G5Kk0
 5Js=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 23:13:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MnzjY2N8Vz1Rwrq
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:13:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:to:organization:from:references:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665641616; x=1668233617; bh=zJgjNEVAuYaGMQ6lYH0Bn1yiH1iSfy1pag8
        xbODnifE=; b=QOBviTSaW0O1LDF9+ifnXYDX2v9KWVc+K6BkTutjdMymntcoPkd
        /4V2545+/Zg6hL5zy2I/h88r1/RXG7Imb+nJKBaHn04lIbEZRyPi82/YREMRcVKz
        68WnXqDQHnS/anIfGWPwu0neQpevEqrIw+iWV5rCSzyOSSOleOO6Scf3wbNo3jcv
        WS09Z0ByC/rgPxacaw+c3a8xAsNMXBeuY3pSnAQrJRcrVaqfShKy86um+RQrd7C3
        TNlEHWlCzMBKTv6sTBDV1KkQYbhvPql1xSDc3TaBsmP8nLvkh0v0l19g0/xFidMo
        AR9ILzIKUqKbJL8TDQrML8QWbIoJ1O3vBvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yIf2SDXweCqm for <linux-kernel@vger.kernel.org>;
        Wed, 12 Oct 2022 23:13:36 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MnzjW4dnDz1RvLy;
        Wed, 12 Oct 2022 23:13:35 -0700 (PDT)
Message-ID: <4517c95f-1dad-5a8c-5202-073d0a7eff29@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 15:13:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: drivers/ata/ahci_st.c:229:34: warning: unused variable
 'st_ahci_match'
Content-Language: en-US
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202210121422.MJsXaw1M-lkp@intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
In-Reply-To: <202210121422.MJsXaw1M-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 15:37, kernel test robot wrote:
> Hi Damien,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   49da070062390094112b423ba443ea193527b2e4
> commit: ecf8322f464d62759d838ea62cdeff6966a60134 ata: ahci_st: Enable compile test
> date:   3 weeks ago
> config: mips-randconfig-r023-20221012
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ecf8322f464d62759d838ea62cdeff6966a60134
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ecf8322f464d62759d838ea62cdeff6966a60134
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/ata/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/ata/ahci_st.c:229:34: warning: unused variable 'st_ahci_match' [-Wunused-const-variable]
>    static const struct of_device_id st_ahci_match[] = {
>                                     ^
>    1 warning generated.
> 
> 
> vim +/st_ahci_match +229 drivers/ata/ahci_st.c
> 
> 76884cb2f7da52 Lee Jones          2014-02-26  228  
> 09de99db23df55 Kiran Padwal       2014-07-22 @229  static const struct of_device_id st_ahci_match[] = {
> 76884cb2f7da52 Lee Jones          2014-02-26  230  	{ .compatible = "st,ahci", },
> 5e776d7b20f040 Geert Uytterhoeven 2022-03-03  231  	{ /* sentinel */ }
> 76884cb2f7da52 Lee Jones          2014-02-26  232  };
> 76884cb2f7da52 Lee Jones          2014-02-26  233  MODULE_DEVICE_TABLE(of, st_ahci_match);
> 76884cb2f7da52 Lee Jones          2014-02-26  234  
> 
> :::::: The code at line 229 was first introduced by commit
> :::::: 09de99db23df55c7415d110f6c62281dedd77384 ahci: st: Make of_device_id array const
> 
> :::::: TO: Kiran Padwal <kiran.padwal21@gmail.com>
> :::::: CC: Tejun Heo <tj@kernel.org>

I am at a loss with this one... There are plenty of patterns similar to
drivers/ata/ahci_st.c doing something like:

static const struct of_device_id st_ahci_match[] = {

        { .compatible = "st,ahci", },

        { /* sentinel */ }

};

MODULE_DEVICE_TABLE(of, st_ahci_match);

For instance, in drivers/pwm/pwm-sti.c, we have:

static const struct of_device_id sti_pwm_of_match[] = {

        { .compatible = "st,sti-pwm", },

        { /* sentinel */ }

};

MODULE_DEVICE_TABLE(of, sti_pwm_of_match);

And countless others like this for STI and other arch too.

So if CONFIG_MODULE is not enabled, how come we are not submerged with
warnings about unused variables ? Is mips arch special in this regard ?
Or am I missing something ?

-- 
Damien Le Moal
Western Digital Research

