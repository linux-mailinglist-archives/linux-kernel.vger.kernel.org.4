Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505D6C6F93
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCWRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:43:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774211B319;
        Thu, 23 Mar 2023 10:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubq7aEr7yMdiR2fyIOd2ASTtZddRyfE/mHCvixLrovXcguHVAZ/GaDpKtUX102bt7cRSWWDSBCFO4dh+446PhGDO+8vcn3qrcw5zD3znupQuxmivqKDODsyKZq4A+0jDk8TaeK65jJCd+2BJe3JhzaT0p+pHkthlahqbHvgeHP7CDraj8WqQGMuL9sghDHVXjgdX926VyuU4LMf/X/tB+yJ8R3grKj5jsLUmfmQvwhlWAArnuumFifcHgH/c3Y+fLPjUWpRXqXTgkQ0l5re09//RVCWtHhg7VSa5ctzaj1rluvXYSb3qO9UawQG7RnCJhGOxExQuR/uNC5gDkDXR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svTTzUsgC1/0Zb5YEGiI6w0xHDQwHLyuT+ewnZsCo4E=;
 b=LSrTZxERtJigeGImEl2qnPPkuESygKrVP2dswYvfSuM6RcnEWEXeYXZnh6vpCJNjVvFReMuhHxKflA2oDU3gdBEfZ/YgsEHU1bPt4i/JpQqfXV7zJSFyBrrYeOq0ml3A28Ca1pSkV7FCiNmyC9fJnWm3w68JOmlCY1M0Y1ftOLYJ+HCRamwrjJPlK2ZlZSrVdU/glXJ9KA0oIgULhNfm44/5C1On/i1576e8GWsYZTg8Lw0KONMlUPtIo32YC416syWoKQ3i7l796kuD93k1mjT5lZl/TxtYSZ1oEZuHNB5+JVIj1eZUZc2vznK5OhRL1H4LTM13d8fgo7dyHkedrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svTTzUsgC1/0Zb5YEGiI6w0xHDQwHLyuT+ewnZsCo4E=;
 b=IZV75Z+BS8ri1QfbPT8qoERIUmRx7tplPY8F+ggVO/EwZfKa01qy0gzjMQ5BTaU7jcUyBouz9ydfmfbv6Xh+o3yk97W/dGT2Soh6TvXRwLMqxc9UGuLqR0PX8KCbAfQG69grncjFS6hdRH4XO4/DS7ThcXpb9eAurJCCY2GeKQs3oOUbpCUKoeHqyko+h1ObpYHs/U99r8IHfG6qtLGQmXpk21Mq6kfcM48293KapzdCH8PdY3r24/Q68/23kmAYAXwags63J4eCX4+2YZk2cEP+Tk3JDqPfm/ZFKnZrD1CNuambtL8bNRBi4CZqag6CB5dznmyokqR3KZg8DHxRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 17:42:56 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 17:42:56 +0000
Date:   Fri, 24 Mar 2023 01:42:45 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     NXP S32 Linux Team <s32@nxp.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 1/6] pinctrl: s32g2: use of_device_get_match_data() to
 get device data
Message-ID: <ZByPlYRFxDm/cBCa@linux-8mug>
References: <20230323144833.28562-2-clin@suse.com>
 <202303240158.uaLsPb4O-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303240158.uaLsPb4O-lkp@intel.com>
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0dcef7-71e5-463c-5744-08db2bc6090c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeMGGhhNfFb2ltWJGmIB2F4wo90a8SV6H4VnfkS8796CQwTRNOUB4JUE0Vu7L2nAbv72OfLGtioez9vXJP3OzgAYz5UmKrklpSAqTH+S3ttjJtrtpyQeqeaOUmkppNv5tz9SMZdMs1yt0y0DeoGRrh46bGdRqJ4gTerSCvUXUPRmoeZRhbJ/bp9c65KfNBpaF8hZD/enQ37h47d9+95X5PnYKwwyJuLHt10XOvNH1RMcgd75QFKmT+K0WqftV/Pik+jZefuzV08Qg+KII/UurAtTM94KA43Cz4GyNZb1msgIa8TRnvov4rStjQA+wyEgtJfuLerfi2RHAVjqCl6+8iu/SnbzY/TMS7J/rBlk8o9icY/pvUaqLds5puJ+1RLONB9CV1jJUQEHttJMnwqQXd5UkyiYA5OLkKkBhIWInZ7ti8n6Lm3dhuPQQ41AMqGPEbYlx2gzp+l44BVw1t1vNFHMAL/XsVV+AfagduJEFLh2eGsjZWZjZZESm7O7/rLqVe3cmuLQ546tGvSxml9x70ZJS6SVZ7z+1qlaGpoXzW4y80icFTEM0cMdniMaGI7Rth5pXI+Su/kalLVjtWn7uSPmnQ6Ql2EJiJDJmSnGufxsE5I1DB1JrUuztJ94Lm9qF0nm8dUQLHAdPjNoPGXapdI/zSwctfan0GdT3frPIHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(107886003)(6666004)(6512007)(6506007)(7416002)(26005)(6486002)(966005)(186003)(9686003)(8676002)(110136005)(54906003)(41300700001)(33716001)(4326008)(478600001)(5660300002)(8936002)(316002)(66946007)(38100700002)(66556008)(2906002)(83380400001)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oXyC345UaGq0kXOasWODws7XLHIEDSjGOC6BUBPXXqGBkHRPo++uMeK3v5hC?=
 =?us-ascii?Q?ZxOHb54rpsvp7bU9wlRn7sbRg8Zs1q8+/ubyMJUSjawlfgRzSTqd7NQTLdcC?=
 =?us-ascii?Q?jsSew7bKraTtV/dsNxnjq+HIB66Ef78+l2uSJRPEZ4LRuytkfJiJINemKcX1?=
 =?us-ascii?Q?KvlC8h9bjHSK+fHLVSJXXvjt/TJsAp6ZLUyKo3m+TLij/yWR4j2900ksNWAG?=
 =?us-ascii?Q?SZCLxI7ylzwY5M9tLINJb6Txwk0dU6GsUJ1L9JoxLWV1baJkKm3R8vNyC7hw?=
 =?us-ascii?Q?Um6WHzanYsSFhn0wALCaG/lmQ+fP4WzLd9lgkqTVukEp7t7N2YAqzO/oLXAQ?=
 =?us-ascii?Q?2ThrvodeBPB9DWCJ1FNISroAlDVpntHutAs24ioIyZiIofKB0fQNv+/xYe4v?=
 =?us-ascii?Q?BDagpC/9fW4sQyRCbSHyIIk8hxPdpJT/Kek2zX18y9AwmtsgDlUfy89N9mQW?=
 =?us-ascii?Q?AMO+g8o1BBdA7KnLSz0IBpTZYQxX/9d9NHZ+hyeoEY7DBI/aRFvK/jfXlbP5?=
 =?us-ascii?Q?RlH+BjWB9K7e+s8uqMao0t7nz35JA+/ymygwu3UQ3ejGhl7frVfF0ShDouWm?=
 =?us-ascii?Q?BWYpsOw8yHT0VSDxulSsgi+GQjTk2V0NK2AoWnO2kCEIsv5pUukHroUaBJFc?=
 =?us-ascii?Q?krGRKk5jnXjsjztCdbliOHWo4hSDieGQSCP0UUCY92Uj3KNXzDtjfWeD+11G?=
 =?us-ascii?Q?uEiu4blwti1wpzf3ZByVQhgyaI8ZCpyptP0+cXhF2Oi8Q/u8+jXtW2AssOam?=
 =?us-ascii?Q?CkfWJ41bLxmuUP2I2W4Dcw5nHyieLsLhuHtIbrGIev5dnoNow9cHFpaD8+V0?=
 =?us-ascii?Q?sSQCKH7pf/3yQxOSltYTobDW0W90Suf3jxxAtuSehedpO/kNotLkpzpzI4B7?=
 =?us-ascii?Q?smonnyH8yt2doYFQ8oQAN+09NgXL8oul/7gtcNfNTASHQ80C2jIAWjTw+w+P?=
 =?us-ascii?Q?OYEa30RL1D3/BtPpnvzwNF+au1cy/gK5po45ptd1a3zsWzQGm7f7h+4IXhHv?=
 =?us-ascii?Q?iuFyNzQ/TI0cYYJMTOomtP50zOjtTY4yqjEa9bDfK4UQd6h2BV8swQXiDaeF?=
 =?us-ascii?Q?5Z3bcS05OUmMwti2PCCD/Kg703n2Ha3804KiKqT3onf1d52yNr3MFKo0hjFz?=
 =?us-ascii?Q?eGjGnIM+TaVqOzMUokWPlneLSDBtaeqbZhR1SfD050Xa76Ethj4XEABrMXgR?=
 =?us-ascii?Q?o/6GExHAtsZapMqhgoBx5zQZs9eaij5uCmu8RnP1an/I4BTCwyH5ITEJe0AK?=
 =?us-ascii?Q?zw2PHwcEtm0fuFbSJL1LBv4uEPDK88sBH6NE2h9KQOb6WmaWfjNBwSp363uD?=
 =?us-ascii?Q?8y5WQrMdJcOktMufYDym4wQiHchLYF9gfkQO2x4he/7kqxvv60hImtjgtHkT?=
 =?us-ascii?Q?+ydOfex05w8wyatCAyplsdWH/oL0GC9+23XHXtpM2JvkqezqQeai79+BsA5B?=
 =?us-ascii?Q?tM7/1iw2EB8Rpxn0I8D7B16yWf7vflh2bCsmu8ESg2wmP6NUe0119dPruRwc?=
 =?us-ascii?Q?zOC++Run8ibQoCDGYEEtDwfup+4fumlaF/Fe6QSZ53QOt4VZXWiH2o7pj++l?=
 =?us-ascii?Q?z4uakohHDm+sFwfs4gw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0dcef7-71e5-463c-5744-08db2bc6090c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 17:42:56.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9W2Tji1Onln15gk6DzLaQDxdzebNCeWtNxUQodXqUamuQ6bhqCMe/3uCehN3FbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:11:37AM +0800, kernel test robot wrote:
> Hi Chester,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linusw-pinctrl/devel]
> [also build test WARNING on linusw-pinctrl/for-next next-20230323]
> [cannot apply to linus/master v6.3-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chester-Lin/pinctrl-s32g2-use-of_device_get_match_data-to-get-device-data/20230323-225141
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> patch link:    https://lore.kernel.org/r/20230323144833.28562-2-clin%40suse.com
> patch subject: [PATCH v3 1/6] pinctrl: s32g2: use of_device_get_match_data() to get device data
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230324/202303240158.uaLsPb4O-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b716f96ba217e92e79b0d888f187ba0f30d705cf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Chester-Lin/pinctrl-s32g2-use-of_device_get_match_data-to-get-device-data/20230323-225141
>         git checkout b716f96ba217e92e79b0d888f187ba0f30d705cf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/nxp/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303240158.uaLsPb4O-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pinctrl/nxp/pinctrl-s32g2.c: In function 's32g_pinctrl_probe':
> >> drivers/pinctrl/nxp/pinctrl-s32g2.c:747:40: warning: passing argument 2 of 's32_pinctrl_probe' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      747 |         return s32_pinctrl_probe(pdev, info);
>          |                                        ^~~~
>    In file included from drivers/pinctrl/nxp/pinctrl-s32g2.c:18:
>    drivers/pinctrl/nxp/pinctrl-s32.h:70:54: note: expected 'struct s32_pinctrl_soc_info *' but argument is of type 'const struct s32_pinctrl_soc_info *'
>       70 |                         struct s32_pinctrl_soc_info *info);
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> 

I will appreciate if someone can give me suggestions. In fact the patch [v3 6/6]
in this series can solve this warning properly rather than casting data type,
should I combine [1/6, changed from v2] and [6/6, new in v3] together since
they are relevant?

Thanks,
Chester

> 
> vim +747 drivers/pinctrl/nxp/pinctrl-s32g2.c
> 
>    740	
>    741	static int s32g_pinctrl_probe(struct platform_device *pdev)
>    742	{
>    743		const struct s32_pinctrl_soc_info *info;
>    744	
>    745		info = of_device_get_match_data(&pdev->dev);
>    746	
>  > 747		return s32_pinctrl_probe(pdev, info);
>    748	}
>    749	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
