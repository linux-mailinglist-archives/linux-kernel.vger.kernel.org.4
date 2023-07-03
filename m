Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC70C745825
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGCJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGCJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:13:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94AE12E;
        Mon,  3 Jul 2023 02:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1xHkIb9Sbxvr4xJqBmyqYdXMymUQ/+k7CnWe8t9ozRfjKC1e2gPJTZfgZpLhEZ7JXF8y5kYUCdsVXNp6F3qRSuWiJYRjk14L5D/FTg9s4AH2hMqUxUlSDUoKFajxQFEfhkyvRqHDeBzvmtjzigDzcCoPlRT0QUFfG4d8MN58qbUUqg7pkdZAoMBizHsa2CuhFwj4IxeiXeGXIpiz7hiYEV+KGVl7lzEB+BeUuWNONwzy7UZJv4RDd+drNFgvTMVEIUq45TkHysrjGFWI+Z9qfBrUIHhG4Kl9o31ydbp4NbBed2sZXt2XeDkIFSFmK58VRcxsp5/6qtWelhKZbDa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czK4J5IXuhM9FcHbc3AGmLW4qty5n8A7jCu7uUaSXaE=;
 b=dbgDqvBYLuEozdIcYI/Da5ZMxJRCSKiGXzePxP3TlKDS2tqYOhzViU0QDZ/EGNhmsIlAs+ERd1VPi875TAyqziZMW7sx8OtbCZGEcY0DCseTfvi4hU/9pQu5jLBqIIUIHna/uuCNei9xbw9Z3k25d+LpNUlFsXB53VUcvgET7ef2K+p+8L4frj0u4j+TWuGcUkmnskudBCGsT2pH8lmFem0PadQ65IvrbqvGSCwNjxJCU4hNHhO0uYFstdvaHxF6A9798znMxnsdejiYrSth0Tuqpm3HPgVhmVxd6be2VMyIHn7Rir87OVBLAnX2TJuGLunfTaqBaOgyFecbyJACUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czK4J5IXuhM9FcHbc3AGmLW4qty5n8A7jCu7uUaSXaE=;
 b=SU8O+Hw0TMTkpu0cu+voeWHi9pzPWwTbsaBKLZggBTsoYyMSqfT8k0D2ibGF+4/gG1e3ORkgViy3FxE8x0Gx8PpLVksFY8MIWNj0s62bx4dOxFwN8NscDfE32lQCTf6RTkMHMPXVxuCnCxNw9WJuJd4zxnsbjaqlPIpDxc9Lvzen55kSEBHcp9Mvf4o+B3ChtgdOjWjJrPnXgPxA1DtfRJtcxIG33VKtokhyPEkfddBUnS35hiINhNUAzEQKkxfA4KaQsa8YyDTYKAMrZC4km3WJl0ISWg2DC8lwiYxsJrPjTgU22tOfrHypYQEJXmcWxgumegcdepQffmKM8gHMbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 3 Jul
 2023 09:13:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:13:38 +0000
Message-ID: <690b12b7-5586-6ade-de83-99f463bc8397@vivo.com>
Date:   Mon, 3 Jul 2023 17:13:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 01/15] genirq/devres: Add error information printing
 for devm_request_threaded_irq()
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230627101215.58798-1-frank.li@vivo.com>
 <20230627110025.vgtplc6nluiiuvoh@pengutronix.de> <87h6qpyzkd.ffs@tglx>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <87h6qpyzkd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bc9ed4-346a-4e04-1fe5-08db7ba5c992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6g2591paU51B2LYfKRd3d8yTh3hnH7RW/52U8T0DgoZ/TcZOBLFgaTWmhSDCXX0b5HH5PRolb6hi8tJ+awJu4SPYiFQopWd1v8WK6ciWg80J/FudpD26VflnwIvuxfYu0iqpCX3UmFs+MGq3USNh8tMWv7ImsnMyntqUipN1sp+m5KegxnLKRH3xeu12qEBEOw5FPX99Zm/epC04jN2KfYTn2IXBkGaRQKIkBWFDO/uabW8fzQHUdEJkiyjQtPiBU1fWFVfJc6kBL+oTj6UhOAGN3ZatERcnB2mrNMJq4MRAtsdL5r2oIs0N1KH1A2aflBrMJakDeUW5r93Cu1N0/bqa6/yWA2c+WR8rjFIErVNaNs2GEVih4O6WvyGAogf6ZVA8xQZQsL9YnJS0ZooF2PDLTFYtweFBIi4oYqmr3RoFulhN/Wven6fSgK8gDu5OYf/1CwCTKZI+IoiFA+16Se/DSuAaj4sRBhei3y6aR6XmwSo6d68D02rKhCYmCeEae1PV+ZoXEnhcvuSUbJZC8D12SFWzYsZ/EvtHTaSZKffJiknBDqHCqqdfC9FpcujnxuGeQDsUoaU2ziMVoMJhzPztqIjPLAIv6ajG/PKWot76MjAeW4TnAol4k4ADLAteCHZi40h3eeoxMRKaak6DufcDULEC2N/gE4isFaBp7TqzFEJicjTapjcprSNVMQA3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(26005)(66574015)(6666004)(6512007)(2906002)(186003)(38350700002)(6486002)(52116002)(38100700002)(2616005)(83380400001)(86362001)(53546011)(6506007)(110136005)(31696002)(41300700001)(316002)(36756003)(4326008)(66946007)(66556008)(31686004)(66476007)(7406005)(5660300002)(7416002)(8676002)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJlZ3VDTGJWMlozNkFoRlgxTSt6S2pTS0J6d2wyQU9DVEJVVEJhUStDSU9m?=
 =?utf-8?B?K3hGdXRYeFRocWFwTzdNeUx4V1Z4emZKdGdnYS9iWmpRQlFPeGNVYmlGWHRw?=
 =?utf-8?B?ZUptbU9lVXhha0lDZ1k4WVdJUW95MEV1MTA5SzFYVVhWMERMbXhRM0dWdmVR?=
 =?utf-8?B?Tnl4OWNzMm1qS2JISVc4WGtkWWFiQ2krNUlTNjd4Rkl5MW9mL1VDNXZhckY5?=
 =?utf-8?B?M2htazFsY0pDVjlYei9kVjlxTDRJcllhS3VWbGQxWnUvWTB4VFZXNk9oVFNQ?=
 =?utf-8?B?a21vMU5yL1U1ZDFzRTNMdVgyOUphNXhrbjBoMEVnR1Z2d2R0clh3R0FtUHVp?=
 =?utf-8?B?SUk4WXFrTzhFVTI3WkNNSXE5ekgzL09nK3EwZEpOTWpKc1BaWmxHSXNqY044?=
 =?utf-8?B?Zm9ISHR4UWo1SHBlRjk3by9jUTc3TG9VK3B3RmtpQ1ZVU2JubTFvN1ZWRzhj?=
 =?utf-8?B?WXlILzV2ODEwcFB6NHRVUGEyQWM1MzRXbUREM2hEK25XdjZtU1Fmb2E1T1FY?=
 =?utf-8?B?cm1rMlhPbVF3UWR3UG5qajQrMVFKSzkyVXlNcVBiMjFNL3YxeUxidCtVbzhZ?=
 =?utf-8?B?UmlWK21EUE4ySkM0US9sOGc1SGl5ZnpVVCs3bjJneGhvL1NTWVJPczFsdmhw?=
 =?utf-8?B?bjNzamF3dUdVWVloQm4zMi9adWhaSC9iOWp0RmFhbEYrYitxNDRWRnE5U092?=
 =?utf-8?B?em0vemd1R3RWOEFSSUREcDZ0RmoxRlVNeDVXRi8vazBPZ29nbnI4bFg5a0ta?=
 =?utf-8?B?MW1XN0RTT1RnditDb3V3YjRsQnJlUlR6VUU1N3ZjWTBqN0RFeE5nNWU4eHg4?=
 =?utf-8?B?L09lU3Rlclp4RmE4djljNkRDZGdrekFUdXZvS1FHWDMwZm1FMlB1bVhMWW1I?=
 =?utf-8?B?Zmw5NlNDcE52T2piaUhDcmN1WE9CZS9oRUdHTitLNEpKSVN6cVMzUHdjUnl4?=
 =?utf-8?B?SldzaklaUFFyUXVzSE1Bb0VCbGdxdnFSN3VlY3NIQ0FNdGx3ZjkybW9sdytX?=
 =?utf-8?B?M293VEFhTURpWmhuUTl0QzJTYlp6aytqaVZBekcwc0lSZ0UzbWhkU1ZzQkJT?=
 =?utf-8?B?UkJSRmVSa0dVUDBEd1ZRVzFCc3JYbzRjWDk0akZmZlVqOUN0a09TeTc4bzhI?=
 =?utf-8?B?U0dtMXR3ZzVnaWsyY1I5dXRnUTU2YjRQSnJkMFNJWnFvNnRscE1kSXhDdlhy?=
 =?utf-8?B?bXVEWDZrM3BLajlpTU85dUtZVy9EMkpsSjM3VjU4NmZObGF6N2Zrdm5HMHRQ?=
 =?utf-8?B?aGNHY1pXR2xuM1Nsalh0b3NXNmYwRmttRXNsRnN4empMV0dWNnhhR0c3YWJO?=
 =?utf-8?B?VUl3Z0RhZVNtVmJZU2tIalRlTnU0ZXliQTVqK0huc3ZzY21RV2loNjVQS1FR?=
 =?utf-8?B?WE9GOG9EZFJ2bEJGYzYyakN6S01NcU5uWDJLSVQ0UHFVUWdsbEhyM2EvV2Zk?=
 =?utf-8?B?UjBFWXRralJxbFJwM29KL2hLUlpxWkdzbnB5N1E4SlBua2I1TnlMMFRsRHNs?=
 =?utf-8?B?S0d3WlphKzY0WDdZNWxDM1Y1NnUvc2VQU2tySHQvSFRUZ1lxWW9MSzMxWHNO?=
 =?utf-8?B?TVdEbzhvSG0yRlp3TU1Ia2hNNnZZUUxFUGNrT3BZWWFhVVNWbG9CaVJCSzlD?=
 =?utf-8?B?eGRhZGZiNXdaRUN2d3IwRlF5ZkZBWjZqcEJOdDVSbWpIbmp6SGxZZFRvMFZw?=
 =?utf-8?B?ZHc1dDBYZWc5MEpLNlU3a01SbnQ4d212Q0FSL0w1cjMyNUtOcGdCRGcyVXdX?=
 =?utf-8?B?T21CcDlxaWtKR1NkN2s0Y0FjcFFmUzR4WHVFYU9iNHNpenJ1R2ZDczUwc1p2?=
 =?utf-8?B?aVlhcGdkUkpScHlQd0drY2FSNWZyelVsYk52aVZ2OUVPWk1kcjBvekFHcnZs?=
 =?utf-8?B?ZmZ5TXlnNHJXR004WTVoU3lodjN5UFcwQkNLWW5INEFTT01DTDhZRE9QK1Bi?=
 =?utf-8?B?UTUrdzBiTXZ4SnJNdlg4cUNUOCtFQm15d0lDVDNrWDZ6amdWejFmWUZ3RTRW?=
 =?utf-8?B?a24vaGpraFovK3ZYOUNsZjc1aE8wZExJcmpMaTRRREJzZzZ0OHhoMXRBVWhL?=
 =?utf-8?B?SXlBdFdlVzdlTUZ4bGR6aldhY0liQTRmWWd4MDJ2TTFMTU9VeWM3SkJrU1V2?=
 =?utf-8?Q?tcer0ixeYUQPoh739LvZi58+g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc9ed4-346a-4e04-1fe5-08db7ba5c992
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:13:38.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45HHPW41jyFfU6ygCABPNLCVpuXp5YnPFEFqyreTnASH2xNOJ9mJy5fIzpwYHJuIiVU7Rtje5G9JegX6uRNFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6507
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/30 19:11, Thomas Gleixner wrote:
> On Tue, Jun 27 2023 at 13:00, Uwe Kleine-König wrote:
>> On Tue, Jun 27, 2023 at 06:12:01PM +0800, Yangtao Li wrote:
>>
>> While I assume changing to dev_err_probe is a result of my concern that
>> no error should be printed when rc=-EPROBEDEFER, my other concern that
>> adding an error message to a generic allocation function is a bad idea
>> still stands.
> I agree in general, but if you actually look at the call sites of
> devm_request_threaded_irq() then the vast majority of them print more or
> less lousy error messages. A quick grep/sed/awk/sort/uniq revealed
>
>       519 messages total (there are probably more)
>
>       352 unique messages
>
>       323 unique messages after lower casing
>
>           Those 323 are mostly just variants of the same patterns with slight
>           modifications in formatting and information provided.
>
>       186 of these messages do not deliver any useful information,
>           e.g. "no irq", "
>
>       The most useful one of all is: "could request wakeup irq: %d"
>
> So there is certainly an argument to be made that this particular
> function should print a well formatted and informative error message.
>
> It's not a general allocator like kmalloc(). It's specialized and in the
> vast majority of cases failing to request the interrupt causes the
> device probe to fail. So having proper and consistent information why
> the device cannot be used _is_ useful.
>
> Yangtao: The way how this is attempted is not useful at all.
>
>      1) The changelog is word salad and provides 0 rationale
>
>         Also such series require a cover letter...
>
>      2) The dev_err() which is added is not informative at all and cannot
>         replace actually useful error messages. It's not that hard to
>         make it useful.
>
>      2) Adding the printks unconditionally first will emit two messages
>         with different content.
>
>         This is not how such changes are done.
>
>         The proper approach is to create a wrapper function which emits
>         the error message:
>
>         wrapper(....., const char *info)
>         {
>              ret = devm_request_threaded_irq(....);
>              if (ret < 0) {
>                 dev_err(dev, "Failed to request %sinterrupt %u %s %s: %d\n,
>                         thread_fn ? "threaded " : "",
>                         irq, devname, info ? : "", ret);
>              }
>              return ret;
>         }
>
>         Then convert the callsites over one by one with proper
>         changelogs and justification.
>
>         See?


Yes, thanks a lot for the suggestion, and v3 has been sent.


MBR,

Yangtao


>
> Thanks,
>
>          tglx
