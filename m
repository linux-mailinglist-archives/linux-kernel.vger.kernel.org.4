Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEED05B652B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIMBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIMBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:44:06 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14A46DB0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:44:04 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D1PEST002645;
        Tue, 13 Sep 2022 01:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=frEoeF4FOU2v3QZow3JXwaGV6AH2euc1LPI11obE5Sg=;
 b=MvytNOgehLQtHy5QO83vE2azvMoLpRD84SjTGqRnLkpA1rjtXGy68wTwdMbBrVvbO+H8
 xY1epR6J83cnWkFgey9QOrFIRZyl/pJFfFmCDqPBh6iy9lsUvoR5nteY4Otdtq+R5z8+
 HVxm2M0t1ra5tgxm26HDm6NSa3Wago7FNDLzgmwS0I9UTuysqBdad14oe18cNixSJwII
 PbXEhftAJnmEWTVu0FY1DVdL26EQdkJvw3TEbLy/XSlwe5DRJUVthuPv+4iegueOHzVi
 DkN32sFWZbeo30JgnxOpy7+qaOPahudnTpn28eiYTQ+2L+RKRaRtKSPvX5KJ32vK6cdP bA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jgft1ts5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 01:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2BQzATW1YTgEWgMSDYxK+fTiSHFtjbfETQI5jeHLaO13Wp5h0gJM8zgjKHhJJKZfTO30tBkg56+mdgWBbj6roIlt7+aVg8G78jL7IWr7gjmQexArRgfhN+b3Q8AidQJ0Zm6zzNgVbILhtxeYmIOM0TyqQqyr7q1t7OtB9VHIRg0ZoDI9egvP8BOacE9gQwQWJq8JdIiaEJ91fpaSKM/LJebGlJFeL2Zzx4EK6JkCHPlyl1N6cisaRGw03s8HO2HUlDc1UavO9uqtly4rwvEC0NrvvSwNKjrW4I4H7yUUDRacPtBy3auHCfzRajLUCqJ2tCpVcpUS60wzJzuBps+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frEoeF4FOU2v3QZow3JXwaGV6AH2euc1LPI11obE5Sg=;
 b=ksdtLd3NCSW1cX4Rr/o0/FGbo79ogtJVW4WeWK61ijxwMcVhX/QQxxrjH/tM33koy226iSferrrVylnsONGaZv90NnlKGhDij8hTr7kUFq/rJWkIBAlhkuqDCvp+4oLMuTr579DsJg3iqoiBv7mMKh2r5tSagnSg8kJemp7dewdGRVtFcgsY6yHWB5TfLnoOqKggAjHiWNnASKXLGpv+rmEYaYzXrSjBP5NIS7X3beXDPiosqxGMLkghr+K81LMHEi+KzMB3A2MLNO58FBz25MwhLgCQLRJz31O5HuQRe2MpuNSc0gv/aKUC/RB/0AFPZWeqyHQkqGHudlKewcrUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 01:43:27 +0000
Received: from SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::5077:607a:fb5b:9cfd]) by SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::5077:607a:fb5b:9cfd%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 01:43:27 +0000
Message-ID: <9bbd7ad4-cb46-9fe9-eb32-5bb8321d02a3@windriver.com>
Date:   Tue, 13 Sep 2022 09:43:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, tudor.ambarus@microchip.com,
        pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220912142833.1739547-1-yaliang.wang@windriver.com>
 <202209130732.cQpPG34i-lkp@intel.com>
From:   Yaliang Wang <Yaliang.Wang@windriver.com>
In-Reply-To: <202209130732.cQpPG34i-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To SA0PR11MB4766.namprd11.prod.outlook.com
 (2603:10b6:806:92::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4766:EE_|CO6PR11MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 675061af-b132-4b10-bede-08da95295a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vuqCvMdqTxznFHriJZgb+RuQxpLkaXttY2brr2U2w+PW53Tq9nGD+x/2NOh8v/iILkBjZ3B87fd/H9hvrzH0CLAhu3vGECqgYrvk5daFQGioD4ZkU4LBN1XPwwkWuYYX05HJgS1wjFajpPeBtfvHHN7jez7ePRqV/Tey4yct2fqWvQ9p9T5kcDDw4xs60+LlXmCJJ3Fj5lZPo3u8SyDJ5NLQHeJco1sNke2wLGWkig0fbznvikwQdw4h4cY1d9OLDyDoC8UlvWf8vpeV9LN9ygBa2zLNXSriJlME7VjuoZB22uqlMacDBCD1xRKqOjvnM2cY5lNpdpN7hA/BfVSL/l7qFK0GNTy8m+NAq9ZnxAeXeGMkFPeO01Y2xFcIfWpWjr2EapEabxCr0TOscvhbfw9ufUj9iadB3NgAQXy5BpNmO+StvwrcuULNZMS/lr8OSlnmPCRKLMl8KSdJB7dagBo1pkNI64ha1Ufvl5I5qsn6Pj+WaBGrWPHV/T2eHlgNK2K5hydLoSiK9LT84ujv6j/HjC8+EPsjX0O0w79NyXmYzbGkQdX/mo4Q/aJ1by+dtdXICYyTuKmenMCoYI44QwPO0hRV+XvspmgsDocIca0mqFaROhufMgycFy5B7DPq7nQKqcfjBNBw7uEmy7nXkGmvR/ervsXkpHsMAe+UsR3EIR10M7VpfmIbNs6sBeTWOrX7rwsIqQfsKJ+MPDr4AyvtkKxrsL7EMq1bAcGygPUw2EWzQrZ9pTb+tU3rImweWd5f30GHDE5JWc0PSn9bm1Mj4Us3A/XEw8Ie/nI7FDjJ5GtQyypM1WWojexqVfIbZcpFES9ou4QQfz2DX5yGXGg+I2M//AJZpF01pyDeH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4766.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(451199015)(6506007)(6666004)(8676002)(7416002)(6486002)(53546011)(31686004)(2906002)(36756003)(86362001)(186003)(6512007)(8936002)(2616005)(31696002)(316002)(83380400001)(5660300002)(38100700002)(66556008)(66476007)(4326008)(66946007)(26005)(41300700001)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVMdHBDc1p1V0ZPRWZvNEo5T3VnMWNNSy9IeWVIbHE3anFXbkxOeWZneVN3?=
 =?utf-8?B?c2ZnNy9kVmx1a29nRWQwOGJXZkgyOExoZm0rNjVsbkFwVzdja3Q0Q2M0SlVY?=
 =?utf-8?B?VG5LUFZ4MXcwWWNTbGxLeDFjeFl6cURUQVF3R2RoWWNCN1ZvQXVkNGNTcHRQ?=
 =?utf-8?B?R2tuOUtMLytCNmhKb3EyNEd0d3M5TmgwNEJxZ0Z6UWU5ZUtRbE9pcmNsNllq?=
 =?utf-8?B?TnY2TlFSdkxYbGhBQmJBOHgwQWx1L2Uyblh1SjRDNE9SUFB0Tk5rVGtLWjlG?=
 =?utf-8?B?ZSt4R0VYT2FTbFlyYjdseHZGbFdSc21ZUTY3aFhCdDlpRURRWFArRC8xUmlm?=
 =?utf-8?B?V2w5SlRmUzY1c05mVjBLNmVseTlTUUR4SVVKRGNGeVNSOXlha3B6dGlqcTFm?=
 =?utf-8?B?Q0E3bzNmYWZhYjV0SlQvQ0hBaTNoVFVVUDVQaHRhT0FEd2lTbFdQa1ZyV0hY?=
 =?utf-8?B?T0o3OENKZkQrVFhkSisrRFk5elpIa0pndXpiNDNndUZyV0pSaDc3MzRJaUtX?=
 =?utf-8?B?OVFkdERLYnZpSjROL1luQThPSEhTMFRnQ1p2a1c2TzhweC92ampGWUFsSmpv?=
 =?utf-8?B?Y2w3czJ2dmg2SWpkdUs2eXhITG12QW1zaE9DWmJvVVIvNkZ5SVBPTkZNRUdO?=
 =?utf-8?B?S1p5T2s4Zk9ibjNLbWgxQk0wb0NFaUU1YURwVWl5M3NDTDJxNTE5MFZlMjhu?=
 =?utf-8?B?MHpNTVY3ckd3b0RKOUYwRDcyVUhaYUdmZU5FMXRHRzczYXNqOUZHd0IzMm1k?=
 =?utf-8?B?VU0wOFpXeGUzdWlPb1FBK2tXSERISWVnODcxNWRQY1VZVDdRNlVsTUFNTWI5?=
 =?utf-8?B?amhLV3Q4WEJvblo4UWdCdEFSN2NVNjVWbUk5R0VKSHFpZnY3emJVN0pzOElG?=
 =?utf-8?B?UVNIc2huVDhwcm1FR0NoT2oxSGIvK2owNWVTUTZmOUYwMWQ5NGlERmtuYUpE?=
 =?utf-8?B?VUxxRzJVRy9NZUNISWRPSWd5SVVJWk16d3Z2ZmVjdjdDZXhoWm5CQXpZa01M?=
 =?utf-8?B?b29vMmhhczNtMUdMVzJTK3J3clBtTnQ1aDNIY1o0SE4yTTRWK2dQMjhscmhH?=
 =?utf-8?B?RnlWeGs0MlVsVzVUNm10SnY3eVFHV2ljdHA0ejlyWnl0QnVLQnFkVDNLK25h?=
 =?utf-8?B?N2Ntd3N3YmJ0dEIrcElldGI1SFpyZzd1dzFtQ0lNb1ZPamV5RlVRSGxKbFZZ?=
 =?utf-8?B?S21VVG92K0FTeHRGUTNhVUpFeGs1ek50cVIwSHlIK0tjRk1oZ1U4Y001bU5h?=
 =?utf-8?B?WGtMdXJUMkZVQkFVWXQwUWs3WjNwT3RDZ2ppOWJraHVET1ZlVmZBOUpTTXNQ?=
 =?utf-8?B?WElRUTlYZGJKODBzNk1kclp4QTI1RGQweUFzZGppZlVsbXlKYTUzcDJaTDBI?=
 =?utf-8?B?elhkaHNSWjBVNUt1ajloYUgzYzBkaXlBVzZTTkFrOExkNEU1b05XSURyUWNO?=
 =?utf-8?B?cVpMSitJTUtvSzlTQXM0WFRPOXRJOTRtdDBQV3FPNXRZSDJlRkhocS81OW1p?=
 =?utf-8?B?aDNBSWp1cGtEMTdaREpISmVockhTaU1tMWJhODlxTzh5L3p3aWtKQXF5SWZ3?=
 =?utf-8?B?OEk2MWtoNGN3QkQvOXYvZkZQb1drVmhtZVdFdzdvQ1AwdWlRajN0dkE0N2c0?=
 =?utf-8?B?UER1MU53TTFVb3JHSkp5dlhRYmR6ZjBka0VHTksweG42NjBBckpnTGNXckJ2?=
 =?utf-8?B?ZDJZTmJyZXIxYlcyMkZkcFk2SEhuZjd5NjRSSmFOSm8reXlaZCtJc1V1eXdx?=
 =?utf-8?B?dkl5Y1hZaWZSUFJvZnJPN1BzRmpNN0hieS9ZRmoyRlJDVTFVUDBhcGVscjNx?=
 =?utf-8?B?UHgvdTRBQUdiZWd6T3NSdHFTWG44em1VYTU0RE0zT29FUElLdTloUzcxOTg4?=
 =?utf-8?B?M1d4bjV0ckwySGRTdHcyNVJYbVJLdHh3dDI2ZDJ3dzFuMTBQMTIwOFhqaytN?=
 =?utf-8?B?cHlxNVBvRkRwNE5RaG03N0NTMW1rblo0RmxES0FyMmczL0d1aHM3U0NvQ3pX?=
 =?utf-8?B?QUxwZ0x4aHpMRHoxQTc2akN4ay9HWnV3Nk9LRk9CRndsTnZHMG9SZi9ibHJt?=
 =?utf-8?B?OHpwT2dYc0RPNXlTZ0VJNVhOVXltQXVOdGg5ZWZtMUJKYzFmZGRtVDloV0o3?=
 =?utf-8?B?WDZOOVZxQityYUIzWTNsS1poaUZYK3lDVE5pVCtncEJJTytTSk5yelYvUlNC?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675061af-b132-4b10-bede-08da95295a50
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4766.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 01:43:26.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/yGPcseEQgkoKZi9Pv8HM6KbGAZ3G1VAJGqOWimK3hVtDWf4sOi5o3tb2Kxbist7+EFC0o5Jg9okk9dcnCeRX3f/jdWD6wtIqVWUDBIMHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
X-Proofpoint-GUID: B-m8IN-39V9S-1iVVBUNNryn3M6LoTI0
X-Proofpoint-ORIG-GUID: B-m8IN-39V9S-1iVVBUNNryn3M6LoTI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_16,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130006
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the error, I'll make another patch to fix the error.

Regards, Yaliang.

On 9/13/22 07:18, kernel test robot wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> Hi,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.0-rc5 next-20220912]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/yaliang-wang-windriver-com/mtd-spi-nor-gigadevice-gd25q256-replace-gd25q256_default_init-with-gd25q256_post_bfpt/20220912-223028
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 80e78fcce86de0288793a0ef0f6acf37656ee4cf
> config: i386-randconfig-a016-20220912 (https://download.01.org/0day-ci/archive/20220913/202209130732.cQpPG34i-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/0238f8172a76ee5a84dda79b45911a2b63d59721
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review yaliang-wang-windriver-com/mtd-spi-nor-gigadevice-gd25q256-replace-gd25q256_default_init-with-gd25q256_post_bfpt/20220912-223028
>          git checkout 0238f8172a76ee5a84dda79b45911a2b63d59721
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mtd/spi-nor/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/mtd/spi-nor/gigadevice.c:23:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
>     }
>     ^
>     1 error generated.
>
>
> vim +23 drivers/mtd/spi-nor/gigadevice.c
>
> acb96ecd59f7fd Boris Brezillon 2020-03-13  10
> 0238f8172a76ee Yaliang Wang    2022-09-12  11  static int
> 0238f8172a76ee Yaliang Wang    2022-09-12  12  gd25q256_post_bfpt(struct spi_nor *nor,
> 0238f8172a76ee Yaliang Wang    2022-09-12  13                       const struct sfdp_parameter_header *bfpt_header,
> 0238f8172a76ee Yaliang Wang    2022-09-12  14                       const struct sfdp_bfpt *bfpt)
> acb96ecd59f7fd Boris Brezillon 2020-03-13  15  {
> acb96ecd59f7fd Boris Brezillon 2020-03-13  16   /*
> acb96ecd59f7fd Boris Brezillon 2020-03-13  17    * Some manufacturer like GigaDevice may use different
> acb96ecd59f7fd Boris Brezillon 2020-03-13  18    * bit to set QE on different memories, so the MFR can't
> acb96ecd59f7fd Boris Brezillon 2020-03-13  19    * indicate the quad_enable method for this case, we need
> 0238f8172a76ee Yaliang Wang    2022-09-12  20    * to set it in the post_bfpt fixup hook.
> acb96ecd59f7fd Boris Brezillon 2020-03-13  21    */
> 829ec6408dc58d Tudor Ambarus   2020-03-13  22   nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> acb96ecd59f7fd Boris Brezillon 2020-03-13 @23  }
> acb96ecd59f7fd Boris Brezillon 2020-03-13  24
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

