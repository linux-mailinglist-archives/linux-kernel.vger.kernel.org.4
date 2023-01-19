Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734F6734AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASJoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjASJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:44:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A2C7AA0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674121491; x=1705657491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o63B+TLxt/AttCyG4luQgQNOB4H3CblQPBM1BTdgDIQ=;
  b=dclhL+qn/gnWdSQ9SFH0+YjeEq+kfFYZ+BwNw421rRrB99VWxuUTuqFY
   GdvUxBsji82Jp7uLLNYeZxaLgsconvJy+0e3G8m3cGjVF0/lc2C/XkDCu
   MsnHRs4O2NFYBUcN+qxAuF8E9CAp+P3x9jsgjOrXILNfScZ+COrTx1qq5
   YmzWceungHHPoYkq/9age+odyRxU79tehOf2quxRn5t6vU02sbNnFKov6
   FtjZ4gaA2Yk14NSl7L07ZyXXYLOxesLqcoNkGMQyacesE/OcphNcimjwj
   DLzVdCvtURfh1e0S/vDD5jvLR3lV1/O7tzSeMDkolFabITFdOnqqxLnC7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322928527"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="322928527"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 01:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988923341"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="988923341"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 01:44:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 01:44:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 01:44:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 01:44:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 01:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGgrmhigr0dCxosIX6vcWcca9l9KhBvgQMPbgZ6gghjW254MgByCk7OXaM/mwYVmSyc0ZlzBEJFlWm399mwa2hIPKTNT+Xbaz36Qv0TuQ1EoMVL7o9d2SGWH7FmbCnCJ5spjflc0uAXI6oKcIMcyv6j8MJElIvxMB2WPeexiDf47gecHJHVZxN74+T0nFiNoch4iH6QQICpkFR+TMtQJ/Rj3XDNdC+r2eY4njHvvj92+KgvJCOLzpJlIOwP0AcLAkfBdyEwEHX2qHxJqB/DffFb9oGCRgci0Q4dTSzXCx+euggSQgp9hAsE1qmdoBKQDosuhxX9aDzKzZc44roBJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z8iLMId/4T5H7c9RVLoJCuliqsLihOCCtv3Xl5vPj0=;
 b=Fr8SDe340d1doso/I5gSpsjWjukI50q1BI0W2bnmVxZ4xqVYfsuvnjo2+w0oBZypgjIMiVKl2gceoxaXVqhNdUpa4SY58lEOiCalhTCZHkjn+kVA9YabAcA46OY3Ekc3n9CULL3l2EeF0kDdV/JAIXjP7m2RGGnRXDwDqfbp1t/01P1lSHdcEXyAcQqiNWLFxUEDOFyeBSJWrVkpFo1cIe+AFNi/2zJw7S0RnaJyFdEhPjETb9gqk3BgZeM3STc6R2/oQyYGqL+Bt+SQVPb/h0BuVdV2z6rJGanfcQsrD8/Pk1k4gkBtOX9chEfScOihjsQYKZz8MSlBXWiFPxTLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 09:44:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 09:44:47 +0000
Date:   Thu, 19 Jan 2023 17:42:53 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
Subject: drivers/pinctrl/pinctrl-at91.c:1650:12: warning: unused function
 'at91_gpio_suspend'
Message-ID: <Y8kQnYFJZ0O64IE6@yujie-X299>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: f9adb82c-76a3-41ac-8033-08dafa01cd0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTY5D7obIWB+gOHVAnLbllwg2JqgRPV1Qmxmu33rVIWG/WtsBMuHXTV2Dk8rHpXowbuhwi5v1Tczmvzj1mr3X2V1LQxaMt3Cl7IHW8kTEX5nWqgPAPOHUS0CORu9y+Q24IaozeJ3p2ODVfzgqVPFOgUXLzvKHt31kkx1KcdK/qAKpQhHePquD4vTl84fg+bGUzNCCDfe5r+3h+hsXckhfvPVgQTIGvxCr7crcjkPkMsjew989QhCQRprZPhz6ykd0LsWta0j12kUcxeJASa46I38maqPwcJV6425BVAnfJepwk3ZGUKdJjG4/+d6cgrQgNNCCX8M+b6IY8Etx4rj4kmkMKyWAVMdnR8z87W/7fmSGFUWOljnURWdnk+/2HKfOQMxkbRm7klkRoxWBX1XZZWxY/DQI8wFttQ67ZaxSIQ43478vQsYdF3Hr/mXMD/WI5517SHXD8+nCcbFmOxQjy4utM7MCb9+OFOuxWHd0gPADfQDqS9aXP908eSCshZLrPicQHjK/NK8j3d0pLRNYvV5RYIo7m4V3MH0ZksmovVuSu0XOIJhzkr+EHO8HwpmYFCJ3xuXn++r2ROpppFoOoUIvOnJ+TIZk8r4tE99KLqsvDkTWDj36WUKcuzya6GR24w5IUB/kAH1qGC93EYcBqVSwQkFU3CNAdlq2p49i+PMqFTTALYFqDko7W87OIWdB3J7/WFnDGoM7koztOPPfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(86362001)(66476007)(66946007)(2906002)(66556008)(8936002)(4001150100001)(5660300002)(82960400001)(38100700002)(316002)(6666004)(6486002)(6506007)(478600001)(966005)(33716001)(6916009)(8676002)(4326008)(41300700001)(186003)(6512007)(9686003)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyZSwOeXZnLqx4aeZUO+eOL8uO8LzZhQnr4oE+g9u0dvvx/79lpNp09hh4R/?=
 =?us-ascii?Q?B1EMgiouzoC6FvmG6SZDWqMC3gaF2ImQhdK0LDyYB/QiLv23Mfl4fiF1xmNg?=
 =?us-ascii?Q?2Mx+HjrsAbxkOJ3uCYlGwYLBE65wCdHjHbMMYKJE56FZq0Z0oBbj6NFhH/+i?=
 =?us-ascii?Q?oTdu36mPEFQz0okp9SZJq3l3djGZKD9TQ68wJXfMMQlsZE2Nb1lT8JiyjB7O?=
 =?us-ascii?Q?dLAwIVejpUm6sJ6h5oajWxF25D0YzYQt/QTk4D5kcL05R4m7J2ZWbhF3eZZw?=
 =?us-ascii?Q?CHV3bSJ2NrEn2tyRE2tyCtim9u6+sm3l/HCFDCa/XgKLpE0yayesUVaBuagT?=
 =?us-ascii?Q?zBEwAbRf3ZcNx1jFXXnt/B39p6zyLlkxGZ2/TTI77uX4IdfYLXPZRCPOY9Vu?=
 =?us-ascii?Q?BSY2W574YmubEW3pRrJYxnWhEWqKZqD8UPmNhupcxj6LBXI/2hzpnOMv95sG?=
 =?us-ascii?Q?YbykGnGGH0QIhng2elUvQHdSsG7BDBKo+dKnyfTZDIsU7AoeE0pJGCizMGa7?=
 =?us-ascii?Q?sB4qG3baX7PbQAYDrtSMNh590soCgwAKKtzz6LZ1dcLIn+0wNRda1ktPrRGO?=
 =?us-ascii?Q?7yoGkUPTsUON2cGhLWDH9QS70jRIgtFRsNBzaxJ/JMENUtuwvmK3r/uutkuA?=
 =?us-ascii?Q?Ek/yPM10O//minKrlJt9ubgY21ZueGShigqRDyxc83S9Dh/nynhOUBipXLV1?=
 =?us-ascii?Q?G19HPhRpL0T9jbBeyNe6kAXiSHA+iroYvb8NqPmYzTqTexwJpZhhqZa1D4hJ?=
 =?us-ascii?Q?B7hsxxUdjRmjxDCBeA+JbJjQYwJnBbWkbLSGoFsKV14Rw1jNr3qAJ3rXI05J?=
 =?us-ascii?Q?hlX06pKPqSAyQpkVpMEHl6/gaZtJztcYKfANvrKWZgVGRGVmGY+aw6mbPJLP?=
 =?us-ascii?Q?a3x1uTYGiEJd6HVgfg/w9korLdScaz3dhK/FXDKqGczpdEtuA4W2nxljhdpZ?=
 =?us-ascii?Q?5WRNSrwjKBbf92hDj8s+BGOe/pzDwW+ziTTZAd+sAF0yloQcg4tSFFfcNHFy?=
 =?us-ascii?Q?Ds4dbj5Y1DH2l/LugoQGjUyZuqPJJ1tF6B+JeToIub2nb/KCkrTPA6aXw+P5?=
 =?us-ascii?Q?gMqlm9/gOPpAFPja8E4sNy2uRfotf/mCz4dTj68F1EuQ1bNiyVV2oUnKRh0m?=
 =?us-ascii?Q?U1J7krFpVb8Wyrc+B5bcrE2j2tpO82R2IsdgD8K3/YWwVcdU4KnhfHepknds?=
 =?us-ascii?Q?J0kTE+TPmP/JjF8ONrmij6j7QlYVJ/IurQgWb5ozEaAufI4dFVDRaXc0qFiR?=
 =?us-ascii?Q?hn0Ww6+GnFFFJJbAjDSMNkK6tHRx0upuM4MPHF0o7nEsTKwFg39uOtIgGPJc?=
 =?us-ascii?Q?ZIMmoy69LuytW0LqrK0CZDF8ctUVULtBNN3i4upeuqqGCWts9qwKPImr4Zep?=
 =?us-ascii?Q?6VLmsMYkaR7aQy7aEcZVRTcKhJGXZkAjLRJ0dgvlISKpxXaTzbc9uVC2px5T?=
 =?us-ascii?Q?Dh2SCsRhKCArmoERMIB7t6jlrT2iiYS8GEExOXv8n0Qg+ydkzhbs8UIT1EhN?=
 =?us-ascii?Q?my6B2mUy0i4yzvFr4R+STN4ZIG2P68wUB1DuLgkzjyUeAA8Upfy6YFPeAn8I?=
 =?us-ascii?Q?Nd67pyMMKKq82cy7GHfLweAB/tndoK79UYvqdjI1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9adb82c-76a3-41ac-8033-08dafa01cd0f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 09:44:47.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40vzED90egJhknhMHLZdVu7ukvKxxbd/PWYnoZIOxp6EZo1X8cljtY8KUDFU7q34nzLX2LrGXqy4tcW1cErTJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1649ec55708ae42091a2f1bca1ab49ecd722d55
commit: a575207583676298f3999d41d86d81f7172fe950 pinctrl: at91: move gpio suspend/resume calls to driver's context
date:   5 months ago
config: arm-randconfig-r046-20230118 (https://download.01.org/0day-ci/archive/20230119/202301190231.oWPtSJ5A-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a575207583676298f3999d41d86d81f7172fe950
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a575207583676298f3999d41d86d81f7172fe950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <yujie.liu@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-at91.c:1650:12: warning: unused function 'at91_gpio_suspend' [-Wunused-function]
   static int at91_gpio_suspend(struct device *dev)
              ^
>> drivers/pinctrl/pinctrl-at91.c:1668:12: warning: unused function 'at91_gpio_resume' [-Wunused-function]
   static int at91_gpio_resume(struct device *dev)
              ^
   2 warnings generated.

Please check if the functions need to be guarded with a config.

vim +/at91_gpio_suspend +1650 drivers/pinctrl/pinctrl-at91.c

647f8d94a4e69d Ludovic Desroches 2013-03-08  1649  
a5752075836762 Claudiu Beznea    2022-08-31 @1650  static int at91_gpio_suspend(struct device *dev)
647f8d94a4e69d Ludovic Desroches 2013-03-08  1651  {
a5752075836762 Claudiu Beznea    2022-08-31  1652  	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
a5752075836762 Claudiu Beznea    2022-08-31  1653  	void __iomem *pio = at91_chip->regbase;
647f8d94a4e69d Ludovic Desroches 2013-03-08  1654  
a5752075836762 Claudiu Beznea    2022-08-31  1655  	at91_chip->backups = readl_relaxed(pio + PIO_IMR);
a5752075836762 Claudiu Beznea    2022-08-31  1656  	writel_relaxed(at91_chip->backups, pio + PIO_IDR);
a5752075836762 Claudiu Beznea    2022-08-31  1657  	writel_relaxed(at91_chip->wakeups, pio + PIO_IER);
647f8d94a4e69d Ludovic Desroches 2013-03-08  1658  
a5752075836762 Claudiu Beznea    2022-08-31  1659  	if (!at91_chip->wakeups)
a5752075836762 Claudiu Beznea    2022-08-31  1660  		clk_disable_unprepare(at91_chip->clock);
795f9953eaccf9 Boris Brezillon   2013-12-15  1661  	else
647f8d94a4e69d Ludovic Desroches 2013-03-08  1662  		printk(KERN_DEBUG "GPIO-%c may wake for %08x\n",
a5752075836762 Claudiu Beznea    2022-08-31  1663  		       'A' + at91_chip->id, at91_chip->wakeups);
a5752075836762 Claudiu Beznea    2022-08-31  1664  
a5752075836762 Claudiu Beznea    2022-08-31  1665  	return 0;
647f8d94a4e69d Ludovic Desroches 2013-03-08  1666  }
647f8d94a4e69d Ludovic Desroches 2013-03-08  1667  
a5752075836762 Claudiu Beznea    2022-08-31 @1668  static int at91_gpio_resume(struct device *dev)
647f8d94a4e69d Ludovic Desroches 2013-03-08  1669  {
a5752075836762 Claudiu Beznea    2022-08-31  1670  	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
a5752075836762 Claudiu Beznea    2022-08-31  1671  	void __iomem *pio = at91_chip->regbase;
647f8d94a4e69d Ludovic Desroches 2013-03-08  1672  
a5752075836762 Claudiu Beznea    2022-08-31  1673  	if (!at91_chip->wakeups)
a5752075836762 Claudiu Beznea    2022-08-31  1674  		clk_prepare_enable(at91_chip->clock);
647f8d94a4e69d Ludovic Desroches 2013-03-08  1675  
a5752075836762 Claudiu Beznea    2022-08-31  1676  	writel_relaxed(at91_chip->wakeups, pio + PIO_IDR);
a5752075836762 Claudiu Beznea    2022-08-31  1677  	writel_relaxed(at91_chip->backups, pio + PIO_IER);
647f8d94a4e69d Ludovic Desroches 2013-03-08  1678  
a5752075836762 Claudiu Beznea    2022-08-31  1679  	return 0;
647f8d94a4e69d Ludovic Desroches 2013-03-08  1680  }
647f8d94a4e69d Ludovic Desroches 2013-03-08  1681  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
