Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B7642B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiLEPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiLEPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:14:13 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB34E17ABB;
        Mon,  5 Dec 2022 07:13:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkO+bZRhbydD8pRG52mrD11MtXYmmKMTNjQrxoiUck+j5JVmN+3ohS2P5DfhQA5w75vH8ovslikn3uF/NcZXvt3Yw6tkOBBDGhxVPHR0cj2GEqPr8DjoMJEo45w4ZQJPvRcXJ9GzS5DrxlfmN/sZgWNY+VBu97ku9mUnp5xlkkBP0r2XUuD7h4hYC/C5O4WenWOBgYrl3TbEjWxTAp4LRszz4aTd7RPTTrPnwq24eNvhI62GqkPcka7wFB1r5hcPeNFj6JPdL6JhD1fayf82ZGMtwi/rsBGBSyyeu6sjwbJIUHlQ++IaFU6a3FmLWQFBNUWZpAQWO7ACXUyKLVEPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgF6i5h01XC2Qw/TYvqRwU3kXXsDanA1rAXgaCQe/sI=;
 b=jHUiJVdavpWvznwPIhOkzYvZAjiR1mqm/2Pm4qtpbGgtM3xZDCasOaoqHsLrk8i/KvedHt7VwxIx++63At2PCMA19mKhwBaefzBp5dd/OZZfwejyMVDIzUErLMTxx8HsuA1nsVK+2tMQajJbkIloLI3Ghumpvi8aga7Vof99wjFWCs0v8O2dWkouujL7AFOu6yNhyZAwRnY0aorC3vpMJ9Lc6XwzDb2ntiP9XNI4fzf4qf+Vpq9t1eonCSqnSW9c4wFMAr+fgtaf16vJYZsj5YNGIBjA1Z+XG4lxKeSrFCoqtAl54p5eBPlDTdGJ6eyFK/9zPvOqwHVBFA7t+S6kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgF6i5h01XC2Qw/TYvqRwU3kXXsDanA1rAXgaCQe/sI=;
 b=KS3HeOTlUS+zOzToxVUVIviwXuEVnppZLjlvDgyDUtgY/i2+NJ3xncwhfr9IXzQXKCSpz0mlQ56Mgdmo1KvamayLn1ccctoJdl/N/TerBgbvz/O7LDR0+ffFIBLLIsncdWNm9c0QkU8BKhU2l9E4sYpR9fMxm8xIcjYHv5S0QCmglqlV4LnN2oxWj0QTaj0YPXAwrtCY7SKeFAxE2ipBzrJspf+5d7BbadzKu43gRTHflFdOLsZlwm5B0yVkcJVZ4VoUIMjdXE1GLuQviCJhONAw2kMWJA9RzKpVQAZd1NefJLrMulLhBN48qQ3bkprEqmqlCYs5096nufHTpQzyHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9032.eurprd03.prod.outlook.com (2603:10a6:10:47f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 5 Dec
 2022 15:13:57 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 15:13:57 +0000
Message-ID: <14b50035-c080-2471-7bc3-967fe73357d0@seco.com>
Date:   Mon, 5 Dec 2022 10:13:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtc: abx80x: Add nvmem support
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221201230208.713118-1-sean.anderson@seco.com>
 <202212031600.ua4R64Lx-lkp@intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <202212031600.ua4R64Lx-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:208:a8::18) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: fade3307-4908-460e-924f-08dad6d35360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aslRlLSXAktcV/H5ObRdK/3pQjjByZTQWhBxlUITZjkw+8qXO6PBUAbArHOU2dG7K/DBZwbUXLOPCzvQ5k9c300KonyyEuKM+KefVW2NlhBmlo3V5ueuBNlbhj3VOGhWJS7cW5Ar9gcVOBBToHN8ekb5SvWLiP7IO80S/dB6KGdQv6eag3qCEathVUrLDtvmdiw5wTnhTTWriC4vhXt5LWSqY7kzjGrGwiwRH54klPHY81mVrEmJkHR2Ve5vukq/KHwL7l2Oo4hT94XrFAqD2uVtZTDM2wA7VfS9+z+Tts90MTZOFBjUe4qA/FwPIRLA9oEOCbkWd43hqtcbzodNYfMiQNnp2lfPHFkCRgUWG7Xrwi7QNS4bMg0MH0ZRscgGWUv8MGMfPhHsdvEM+EuHPG4aQ6ORbCYmTdOI7ZUyZ682XbeMzEFaOGcDZmndUOq4RsGYSKXRLOZNGLtxdHCecDfmyz9d/cWmboKls8lwtESC0/kQdnlCOpUzUQqm6/pIEXqYJGyTJyp5YLdz5+bNKRlGoIuue9eAaJHnz/qp92V2OZRR1f7tPb+Drpi8DHi2aGeSmB49CIE+eaO2ZLvQBSiwLurDF1/hMmQubSmmMd/b8DhqzMjMZmO24VEgKD0Dyrk+EINc5KSEPk7vWvGGtTWl7vM3zLQUwB0qXQUUMQ+lW3qHneRWbfuxw/iLf5uMwfi18icMi8l+puMuZz2ezLe++abY94N3x2VDl5FRhBxuKhTzKSLS292/OUJgkok41UkgG8UkrkhPcG7yTI8J4PkQJ+OeJeMX7sKkMkINQEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(376002)(346002)(396003)(136003)(451199015)(36756003)(38100700002)(31696002)(86362001)(38350700002)(41300700001)(2906002)(8936002)(4326008)(44832011)(5660300002)(83380400001)(66556008)(66946007)(66476007)(6486002)(966005)(478600001)(316002)(110136005)(2616005)(31686004)(8676002)(6666004)(52116002)(186003)(53546011)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXIyRVQvN0dKSlBJWnhXU3E4Q1NUbGwwblNXaS94V1NwZUJEV0dCSWMwazA5?=
 =?utf-8?B?S2Z6c0JIQ0tGTEIvNDd1dDhYSE9oM0hhK1ByZGtRYzArVktlUGl6aVAzNUFa?=
 =?utf-8?B?SHRIbTl3d0xBOS80TkpVN3VmLzFLa3B2WEhLckI5UWprWUVrZzJiWklGTlU5?=
 =?utf-8?B?REloQk5Md243WUw0VmtZdzluMmZ2UHNRTjZUUEdVc0VqNkJiYWtkS3cwa2la?=
 =?utf-8?B?d1E2a1Y2Y242TERzdjdsOVh5NXRlc0FzbUxwWENaOFJTUjNoMWxlTm94SVFh?=
 =?utf-8?B?a3JWaE1pR2NVVEdwYUxPbEtiVkZ4c1ZIV0Y4d3Zlb2hmdmd6eTBqWnhYKy8v?=
 =?utf-8?B?bDlGL3RxMmVSTjkvdzlXUzFUbmZkb094Q3NqbDE5emVEUFpkMGxQbUtaQW1k?=
 =?utf-8?B?Zkh5SnJrbGRqb2xEK2ljZ1FwVGg0dVk4RTJmUkNmS1dyTW5rNkxGWVNlUXFR?=
 =?utf-8?B?OVNGT1VMdkRLRXMrSE5xUTdlRWRxT3V2VUNnQS9tSm4yWis3UnpPaDcxVDF1?=
 =?utf-8?B?YVF6dkJramREbCtoM1Z2NkVqeUpIbHh5N0dQVllGQlZtV1pMdnY1ayszcFRh?=
 =?utf-8?B?aHBxWTRJWGY4UTZRS1NSOGIyUkJxUEZyMDZIbHB5QWgyYm52cXZGSGNPK0tF?=
 =?utf-8?B?WGRBRTY3RnRHY3o5YjhVcFh4eVM1WXhCUDNOaXUvbHdGM255cGRyQmozWTdT?=
 =?utf-8?B?VE15dVhmWGh3U01Hei9CUzVMdlIxU0RhcFBlTllOVFZ1WlIzcEV2aUZ5UDVa?=
 =?utf-8?B?NllxNmdCTnhpR3dFMjI0ZFFJUVZiQ1RJVnZmd0hFZzdxUHNCY3dXdEFqOXI1?=
 =?utf-8?B?aXNldkdTMElhc0YzbFRVSmNrM2lrUjlvbndibGdLL1liQVVia1lyaHNlRlh2?=
 =?utf-8?B?R2VDaGRCS3hlNnZFZHd0OThFb2o0ZlFEdGNvSUhGQnlqbjk4bkhmbElEZXF3?=
 =?utf-8?B?RlF6OUhEYnFLKzVnaUJtb05qdXZrVVRWaGV1T1pPdUZOeTlqU2dKOHJ0U0Zq?=
 =?utf-8?B?di9nREkrTXFYTERNb2N4NzZyNjNKZ2hmUy9yWEp2YVRkcTVqRnFqWTJnaEY5?=
 =?utf-8?B?SmRkM29reUtpTVo0bHhlaVFROHBKYi81L0swNTZwb2JpbUdia0NoN3g4VXJn?=
 =?utf-8?B?Mi9HTENGWHVBTkQ4aHBPVTREVVFQTzhMZWNhZG9ETmFGR0YybFQ1WTU3dFpk?=
 =?utf-8?B?WkV4SFg2WjJPLzdldHFOZ2tjaUFld0VlQ0s5a2NIcEl3ZHIwZklRUFY0bThj?=
 =?utf-8?B?dUdnV25ManhmSGNvekM3VDVHUE12cktLckMxNkUvWkJ2cEtHNzROQmlKVkNP?=
 =?utf-8?B?NG9XZEM2TlVlNmJTR3dzb2pVQkU1UVBpRjUyNDlrOGZkL2VGeVRMSEIvekJF?=
 =?utf-8?B?UGloNnoyRGJ0M1hiSzM4WmZSSDIwUzZxdlpNQlNrazhhTUF0cUNPM01qVThV?=
 =?utf-8?B?SU01WkFQc2FXUWsvb1R4b2FYWEgySXlFTnY2eDlRTVBCZUtOYS8ySGthQWdP?=
 =?utf-8?B?WDhIbDZZd24rZkV6MWlVS1FKRDZyanBWbXJGVFA5a3gxa25Lais4S0ZLemlj?=
 =?utf-8?B?Y1pteHVtMXVrZDh1QktHd2RGMDN3SFgrUkVmN0dhMTdrVjVqYnc2ZjErMENL?=
 =?utf-8?B?T3Q4ZmhlcTRpZktwTno0TzZabjFCVmdpenc1QXJSVnRkNHhtTUszM1RPaElZ?=
 =?utf-8?B?d3JhK21Fb2c1cGp3TTRGVnZ3ZmVMRjZxelZ5d3N6MjJIYnFvdzZocklEL2Rw?=
 =?utf-8?B?M2lqRXVVc2E0bElpSTZUTTNUN1hsM0JRVmpSMlNBcHZmUXlRc0kyR2J1NW5Y?=
 =?utf-8?B?eCt2czd4WDRiVzFuMjZ1bXhyZ0tyWWluRXViZGdNM2lWcHcrTkc3U01Na25m?=
 =?utf-8?B?anRvcjFINGJtTkwxWFRMK21CMk9IMFVHSVltQmp1RDFjRjJKVUNGVEYxQkpn?=
 =?utf-8?B?VzRKc09QT0hQUkdtTHlCaElBZE5lUVF4V2ZjSUo5QTRhbGJkOUd2dmRPYVlP?=
 =?utf-8?B?V0RZSEVjVjlzcVJHdU1VZGZQRnRFbVZic2lLUzF3VGM2QlF3V1QxOHVRbWFu?=
 =?utf-8?B?UC9VNnVBbnpud2xVckozVjcwempGSjNvS1VuQ1RoZUxQdjI0WWVVcW5DeGo3?=
 =?utf-8?B?YVZSdzhIRW54R0ZsQzlVYXZ0S2F5cWNBVmFtNVFRdm15YXNrVVl5T1IxZlIy?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fade3307-4908-460e-924f-08dad6d35360
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:13:57.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88LsSEAKpCUtpumIhZ1BtEKyhP2W0UV6ARzHYTLYMnvh+vOIDi0PH+nJugQobJq1zS+VI0+AX/ipwfIXPCjLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9032
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/22 03:45, kernel test robot wrote:
> Hi Sean,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on v6.1-rc7]
> [also build test ERROR on linus/master]
> [cannot apply to abelloni/rtc-next next-20221202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/rtc-abx80x-Add-nvmem-support/20221202-070301
> patch link:    https://lore.kernel.org/r/20221201230208.713118-1-sean.anderson%40seco.com
> patch subject: [PATCH] rtc: abx80x: Add nvmem support
> config: x86_64-randconfig-a014
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/6dbbdf7eef71cb4255c6751bc9762cf02a0f53b6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Sean-Anderson/rtc-abx80x-Add-nvmem-support/20221202-070301
>         git checkout 6dbbdf7eef71cb4255c6751bc9762cf02a0f53b6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/rtc/rtc-abx80x.c:695:11: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                    lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>                            ^
>>> drivers/rtc/rtc-abx80x.c:697:12: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                    extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>                             ^
>    drivers/rtc/rtc-abx80x.c:697:12: note: did you mean 'FIELD_GET'?
>    drivers/rtc/rtc-abx80x.c:695:11: note: 'FIELD_GET' declared here
>                    lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>                            ^
>    2 errors generated.
> 
> 
> vim +/FIELD_GET +695 drivers/rtc/rtc-abx80x.c
> 
>    685	
>    686	#ifdef CONFIG_NVMEM
>    687	static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
>    688				     void *val, size_t bytes, bool write)
>    689	{
>    690		int ret;
>    691	
>    692		while (bytes) {
>    693			u8 extram, reg, len, lower, upper;
>    694	
>  > 695			lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>    696			upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
>  > 697			extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>    698			reg = ABX8XX_SRAM_BASE + lower;
>    699			len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
>    700			len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
>    701	
>    702			ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
>    703							extram);
>    704			if (ret)
>    705				return ret;
>    706	
>    707			if (write)
>    708				ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
>    709								     len, val);
>    710			else
>    711				ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
>    712								    len, val);
>    713			if (ret)
>    714				return ret;
>    715	
>    716			offset += len;
>    717			val += len;
>    718			bytes -= len;
>    719		}
>    720	
>    721		return 0;
>    722	}
>    723	
> 

Ah, the ARM64 bitfield inclusion strikes again...

--Sean
