Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5849B5BE2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiITKVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:21:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD86CF72;
        Tue, 20 Sep 2022 03:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxK7AHvveOct2MWGECNPklzBz2xmRkRdaVHLt/FEhODSabZFpZ+Ufe9sq9d84QT35aawOrkKHLPwYUaLIF3MygRC/EPyBIx2EaeZ9GxF0D2jmTidcdF8Fl3tTvzfgsbzcGtG/a00shOcYuR7USGff5yny/QpUuTVH92TDBE62xMLmfxZj6ClSO0W6g02ZgW0KIXtDV5t001vsSUNM6yb+pJjVktb0lTyfDayrvrWmDpTmA41IkfB2oNYqWPt4PVKvCBlbFLojEtNcNqjFdFFcAfeYKMiagjE2xrEfMZWesl5ZaWETGACTiYcrW2vwQxj9Kwo0eXfNsdm92BNR940fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbfWY8no3byEqeXwRggJAc4O3PtdGb2Zmjk1FGN3Ab0=;
 b=JdkIPDUBotwo09pGDTD6Y6n11des/lOmWAFLn4y+0oonxoVoKWdsHId+NEIHHqnbvCL4RZPdnCRaU3Fin6Wsa4Y4m8xwHC7gk3XlJ1M3x5zF2/vH+CZrE+gSavIS3j6DNmaqwzp/GdJw6EGI7gjS/z9azuHryutm96qB9WK8vbmdfXSSbkf0UK+HYCXU89XlEbGkE4hxvASHEwZFtVsTfE2DcX9iBSwZbh+wKKOSt3tRQsPDDLg8LKVnMBWWkSUrAWa2KBvArdr+ioDO0eSLXJt77X7PTH26Tu7xXk5+agVwpjemoW6WO2wi6DsuP/7zCXN8Mjk6vLPaM12UYZohyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbfWY8no3byEqeXwRggJAc4O3PtdGb2Zmjk1FGN3Ab0=;
 b=OZoZBa2oGbxAyj3tHQF7hrqCuEzyzcTjg2gywDgUiocYQ9IXotMlShYIY1soPfWN+tHVw+jKxhuYQHGfH2P6WBJMOL7o+LD5a4me1cKZg5Skww0fRrlgv5nroZ4GRAIv+wvWqj5hoVMaXGJ+FnlbgcRJmOLeggQB8slsvAJmRLHiBy1sfGk/fvFBPFPreHdjgg9kcJzQvClFWpiQET3CyS3DiEsf5Jod9xa1o9z4h8fJB52eVf4b67tWroTtrnp22aXOlPTZ1wgXO9mWHKH70CwHkeRvh0Od86KFAiKqU63pGe8RTiojLZqtuj+NPYBymhMggZ8XeRU3DmCLOZzLTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DU0PR08MB8324.eurprd08.prod.outlook.com (2603:10a6:10:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 10:21:34 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::2846:1df0:88bb:451f%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 10:21:34 +0000
Message-ID: <7d79d13b-0579-452f-7a07-4e3eba205d23@virtuozzo.com>
Date:   Tue, 20 Sep 2022 13:21:33 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] mm: Make failslab writable again
To:     Vlastimil Babka <vbabka@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel@openvz.org, Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220920082033.1727374-1-alexander.atanasov@virtuozzo.com>
 <21646f5c-39ee-a51c-f30c-272de85ee350@suse.cz>
 <6f5a8f71-3d82-97bf-90e1-0f33546bb59b@virtuozzo.com>
 <60111450-d66a-a146-1a70-0c093400f3e5@suse.cz>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <60111450-d66a-a146-1a70-0c093400f3e5@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DU0PR08MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: ee146af9-7759-4944-d05b-08da9af1e505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcaUzNbALw8POvG9eY4ZRZSHpgniJsgvJZqx5/QomDv2JL0VJ3l2obmNc4CroBtqIdvDJROM/kghz/OO60zfZbpwXcpUefA2qec7CYV+dLRepqRJ7g3VdTViRJij6lUdeLeEL6AbAQkW2ntREbg9pMnawYlowNkdHTZ2PlEa15Lc1Ju5bJrBihma0GS27//98vVhW88EozEM7mPzdOntqL8kPymqxTG8rLFrcT1h0+2dGDwPcCBeku67gKuS0qje3qexo7EKSqtS1cAJPxwp/saU41NEhDvyF698Y9xQdpPosPEZUsTSw/mhvMhTEsTtT4mSQrqFhbsKgVA3mkG6wtURq8oGTJTBnJ0zxBZkZ0mgX8xv0AX2wPV3UaQY/V5oFFYI2Sv0e2QW//iUQKieJcpdgdBseynaj4sj/TeNBeGd2MKk/pjgFuQ7qlKm7324Z0oNTWQeHE7kkXt5x/omoQe6dloy0MuQV0b8oKJIvVwWzeyJRxHd4Semxm0XReb3TVVbyLelRSu4SwYA6VYYEourbfGNOVhzNrhPyLW1T2HRCLXAd4ge0mU7sydIMod3YgpWiYTHw/PNvP255TTo+i1R2Rq463XAZf32u+aFuZgQa+AI7AzJmch7ps/hp5zFNAVPA2cV10UyDvt5I4K0b8XfGdprK+owz4bN7C+unzXFJLMNGIYZHuaYi8rjI8O/LdBk7+qqTmfyeQCq0nFo/Nl4AEIJOS/BTrhEb9uSgL3B9IMhtgldK9yoU67w79k5VVDvIQQ3cF4uBBMMpZSnopGIpL2qYCd3BDrQjws2V0S5ux9uNp5EIGFAt1fbBd6E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(451199015)(38100700002)(31696002)(86362001)(4326008)(66476007)(8676002)(38350700002)(66946007)(66556008)(54906003)(41300700001)(316002)(110136005)(5660300002)(83380400001)(2906002)(8936002)(44832011)(7416002)(2616005)(478600001)(186003)(6486002)(26005)(6512007)(53546011)(36756003)(6506007)(31686004)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhZa1lxR252OU9oR2NERGUxdm9wTTV6Vng1TWdSMUFEcUpQVjB0RmROTHJI?=
 =?utf-8?B?ZWxKdm5yOUpVREIxREpWRStBakxSWFVnbXZRd0VyenBXb0t1ajEvSHRCNExk?=
 =?utf-8?B?S2d5ZG1FUlJkQzJmYXNOL3NuTXVwNFNLV05pYmxId0ZNQWp0UW1uV21QNm94?=
 =?utf-8?B?Z3FHdnRRK1ZMUGhod2ZrVG1RTTIzb1hFTnhxS0ZLWjFKbmxMZU1GYllBUGFv?=
 =?utf-8?B?YklKTm4zRkM2NlcwVE9LbmVCK3ZLT211c1JPZEwrRmplL1ovODVEVGdvakN2?=
 =?utf-8?B?eEFkbEV4WHFNZTVQUXN1blNHUFNLL1VSRnhhWUlpY0UxRmZwZlN3UGkvMGc1?=
 =?utf-8?B?VFdKR1U5Wkhkbjh6QlFwRGhVcTNCU2dtT0JYV3l2L290Z0g5eHJjRFllODdS?=
 =?utf-8?B?N2NlbURleTdFUExTSVhEbTNKQ0xhbEcwcU10RlpjeHJ6QVdaZWU0N0YyN0I5?=
 =?utf-8?B?Rm9MR2xrdmR3NlRpVmloTnJheEVLTERhc1dGVHNocjdIdVZpWEdFSWJxRG9W?=
 =?utf-8?B?UVA4UWFvYnRVL2t0c3ZQMVlZVFRYLzlFZHk4bW8zK2tGYUxrcmdZajcveExK?=
 =?utf-8?B?Ui9HY2xXbk96aDVvZ3dEUCtGMEFxMVQzM3hIMFdVL2hGOHBNUXBxVURaM05G?=
 =?utf-8?B?N2l2YWNTYjBybmNSTGJlQkJ3RmRsSlhZNExDUmdmbE8yb0xxb3J1UnY4dWZn?=
 =?utf-8?B?RjRpZWlEWTcxVTBKby9tNGk5bjJJTjAxUFNhUmpZeUMveUV4a0Vka3MxR3dZ?=
 =?utf-8?B?S1lmMldyY2phN0hYRXlES3V6aURNZ21NeTZsWlQzUmV2ZlFzelVvTEcvNWx2?=
 =?utf-8?B?Wmovc29PZDF1ZUJFTElMOU1jRklqbmZMSDhaNUErdU12eSsyczJoWG5lbFdS?=
 =?utf-8?B?c1RqYUdHbFg4Z0VzbWJ5V2FwM0ZQMklRWGNmcGUwUW5uMHV2a1JybVlTdDlr?=
 =?utf-8?B?VGZrTDQxQXRWdUtLc3ZhWFI0c3NtRVE0NlgrMll3RkR3OW9iWVFVdUFNK2tl?=
 =?utf-8?B?clRmOW16cHo5dG8vV3NGR2dLQk92MEx0TFR5TmxYV09mSzdzVVZaMmdwK3hG?=
 =?utf-8?B?dmJLWFFDdmlqZUxCQnRSVWJOdWlMMmhMYjJsam5wZDNuQjVHRzhKMFAwSEVJ?=
 =?utf-8?B?SHlYUkZNdG15N1BOaktNSXlMK0RDMDNGeFhzaDI0bSt1MG1DcmovMEZuaVRr?=
 =?utf-8?B?a01IMWJXaWNtQVRwZ3RXNDZ0eWthZlJZMTlzMEFTdHltVUl5dXhxeXVtNThj?=
 =?utf-8?B?SFl0WUNlaFFqbWVpaDl6NG9JREk2RXZidmdPZXVTbzlVQ3RaMkZMSVExaFJm?=
 =?utf-8?B?QytZd1AvNVFCQzFyL1crSldXQ0orWlA3bE1DMHdNaDhtWSt5UmdGN2VRR0sr?=
 =?utf-8?B?VVZKY3I4TEkvTlFRUGFOdjZNVFFONndTU2crUHdoNzFMNCtQUDg5VHhSUi8y?=
 =?utf-8?B?anhUbnBjazM2bm02SUN1V0xCSFZEVVJXWlN3Nlh3QWpITXJFYVBlUU5DMmQy?=
 =?utf-8?B?S2wwbkwwQ2xRbjloNEZPL3Q4VUxpTmc5WENwRnpZeWd0d0R0STZLbGNBN1Fq?=
 =?utf-8?B?VEwzelptbW1tamVYWEtjbEQvdlhqbUw1d0s3TngyZGlaREt2dHRkYW14Kysz?=
 =?utf-8?B?UGY2VGRjREIyemtNR1ErUCtGQWhLclkvNU0yUVJvWVp1RTk1ZXdhbC9LYjJF?=
 =?utf-8?B?c3Z6aW1weXVQaTVySEp6RWc1L1JYUUd2Y0R6OXRxZldDaU8xVnRLcUV6bUtI?=
 =?utf-8?B?ajltTkJrbGpHZDE3Mm1odlhNakhFQ0E4TW9tUFhNQkt3WVp5d1lCL2EvVnJs?=
 =?utf-8?B?bmVnN2ErMGJzOTlrLzRmV0xZNytkaUhmbTFzb0VieXg1b0tVeEZTSWRtNkhq?=
 =?utf-8?B?RGUwWTl5TThmTFV5ajhpMnV3V3ZTY2IrSHFCYjJ6U2xHNUJxSFg1TEovckJq?=
 =?utf-8?B?a1FJNVV5VEhOMHZoU3FmOW1WYytuU0VzQVBOMElvNGZZSTVLM2o1c0hoYm1U?=
 =?utf-8?B?TWxPaG1hWFNJNE95NVJFbkhsOTlKY2twNytjcFZQSHQvdE5IOGFBWXlxNDEw?=
 =?utf-8?B?TklDM0x5K2p1eGtUSGpUbjR3d2F6WDJlYW9hZE1xZ1hRekRZeDUvWi92UmEr?=
 =?utf-8?B?SDJ1bGVMdy9YcFg4Y3RzZkhDWDZWODN3ZGFhSnVabTRQNVpmcVRtRXdIbzBu?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee146af9-7759-4944-d05b-08da9af1e505
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:21:34.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adpbvqB9yiO79tGCCQR5HUaQ/zT109Hf0I/XItlFaXF2YN7yRUrco5Am3gVlVl8HP8yOKjDSG9zzOLZ23w0E5wan8iVyRwsbm2RSEsLljayi/Kbc2ypcKIBixIr8CINJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8324
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 12:29, Vlastimil Babka wrote:
> On 9/20/22 11:17, Alexander Atanasov wrote:
>> Hello,
>>
>> On 20.09.22 11:42, Vlastimil Babka wrote:
>>>> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
>>>> +                size_t length)
>>>> +{
>>>> +    if (s->refcount > 1)
>>>> +        return -EINVAL;
>>>> +
>>>> +    s->flags &= ~SLAB_FAILSLAB;
>>>> +    if (buf[0] == '1')
>>>> +        s->flags |= SLAB_FAILSLAB;
>>>
>>> Could we at least use a temporary variable to set up the final value and
>>> then do a WRITE_ONCE() to s->flags, so the compiler is not allowed to do
>>> some funky stuff? Assuming this is really the only place where we modify
>>> s->flags during runtime, so we can't miss other updates due to RMW.
>>
>> Since it is set or clear - instead of temporary variable and potentially two
>> writes and RMW issues i would suggest this:
>> +    if (buf[0] == '1')
>> +        s->flags |= SLAB_FAILSLAB;
>> +       else
>> +        s->flags &= ~SLAB_FAILSLAB;
> 
> This way also has RMW issues, and also the compiler is allowed to
> temporarily modify s->flags any way it likes; with WRITE_ONCE() it can't.

Okay, so the safest way is this?

if (buf[0] == '1')
	WRITE_ONCE(s->flags, READ_ONCE(s->flags) | SLAB_FAILSLAB);
else
	WRITE_ONCE(s->flags, READ_ONCE(s->flags) & ~SLAB_FAILSLAB);

It got me thinking how many places would break if the compiler
starts to temporariliy modify the flags - i hope it never does.

-- 
Regards,
Alexander Atanasov

