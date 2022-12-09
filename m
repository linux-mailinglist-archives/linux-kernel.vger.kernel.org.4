Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9B6488BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLITCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiLITB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:01:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96760AD984;
        Fri,  9 Dec 2022 11:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL70HUsp4ey+zKowV6v0aC35yG3smhnWMAusRot8pUjMMUwx8O86liM4gPGuv/u/7hBBQ+YHygqsW1eT2yPCFJe2M+kyiGdDIC3xmnQs9b5uc7oaJKBO4RrlOC8tf/5WIpk6qu1293+OYjoLkkXIJg/rjE75SziVUDP93wucbR/pRDrK5YbuHj/QKcZWYVnyAQ5HrXmVsoCuX85JgZc5v9wXA1kMFKnC0AS7EqQpdvW//pZmeCPnn4R2VprmJv0/t6R8TP9fbL5Z6XGFcvrpeq+6SWwcBchgEqHAbMR5CTo0xRCK0qz3ZXETOWd9QsuJ1xcCfkWbzrIfVBVGmvaCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAc1/8o7tK0LmC0bYcwGgLDv1FcK+DLUXDRqStKIx8Q=;
 b=kISxd9Um1HpFeC8keIpapPE+QCzjQgOEYqb/9fI9aUEhIpNci2yvuhO1OIh4UQVq+wTwzkYBu9ovLqYiHFBN0lUmqmNB9PSOaiebdFT/WsleN+Tg7TuhdsXgrHYagf0lwCtc96GaTq6W7vCEBfmKXaapFqLS1Fhbd2i3pxffqXkcuEJCbodg/OSMRJI/UwNp1/s0RFDYODWlSUlFGRvOISfPSoEXeVSQgGDXCKF7tNFY/yA0IbE5OYVyeZBHtLnFBaZd5+NBK4hmLKbGokZLsuqZQw8GOveH5bixYkZNMZQtPKejBuhN/eDBC6M05ykp7TGB0Lm5I64L16J1HaHSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAc1/8o7tK0LmC0bYcwGgLDv1FcK+DLUXDRqStKIx8Q=;
 b=3TMrxtYnWD1iUJK8Pi9kdjksD0sjD9uUF0tEe4gSTjEEuhmy9k44AZrys4aosSz7rB6Hdn7ltDSQYMO/hCGBKj11WAPh4rnx3LjQsks1fsK3/DGuAjSVC8TMkZi8b3FnzxW5HIu6/JD875pzjjGgm+6oyyPkdTGFJR+0zys7Y60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 19:01:52 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 19:01:52 +0000
Message-ID: <b49ad56a-f008-55e3-22a7-c47afe5bdd3e@amd.com>
Date:   Fri, 9 Dec 2022 11:01:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "bill.mills@linaro.com" <bill.mills@linaro.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
 <20221115153753.2065803-2-ben.levinsky@xilinx.com>
 <20221125180509.GA622847@p14s> <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com>
 <20221202170042.GA165812@p14s> <ba21b0e5-80e2-d976-1bf3-98a91825086b@amd.com>
 <20221208190523.GA636328@p14s>
From:   Ben Levinsky <blevinsk@amd.com>
In-Reply-To: <20221208190523.GA636328@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::45) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 232142ef-77be-436c-66d0-08dada17d560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SALCsWNkWvMOMuEXHd5go5KoVSudPBPCTTuSM3SxW0TvZe3l6PwwKfvvc3gE3bfI38IyM1KH47Z5L0/X5OGMwD3gU0Fl9TApMNlDQ6fMyebHgQzvuiS5Ah8vnq2sVAS76M5LckIej3s1XO11QR3rJHJ62TeNxvI5zZL54rGVz0StcuIhvjdhosiHC2Z7RCJaamflia6BpZIzZ2srUvc0hUV2wOc63HON2IfXpUjIm4MaYOXui+RHhuVkUSUvaysrwTZ9+ws1sIVyd+ai5YURGvew8/bsu7xivoFAFPCzcad3jk1mXUoOatF8ebnZ+3GN7TJmtOa3SaPGb8U5B/tK3uwenxkveTY8cQytICRAIw2n0YiDW2mmuZdjcrVC7wznx8aDT4fQpQ9vmn361nIK3mH4nymhesWBqjsvGTsNO+RrU972HUYMpM6njzbgnJn1iL2C6fYfHn8NARJCjSUfNIxYv069MKW2cQGzrsnCscK3UwkFMSbTkj9hJzC87Esg4Y9j9B7L9FkVRQVwblttClVY4Um0X0nDYZGXk0n0wzl25mkw3eIewpS5RnsWr5tCdeQgxXboKuM/3IxNgNp/Q53SYrdVWCMAe2A8FRnA/Ovi1nHGf45AlfA4Qz6XyeynJdNk4dEJB/vLmpCESzFEUvlxnC7rBsjjNtprfaHJKz/5mOVgDp/fnatkah/V48VDFMyavq8o+X3KwnAfNV+lB9p5j/Mt/x7XkvpTuDpRNhq62V/kWRg4fnFPygRZ7PR1eU81jFouH48dOWLjP6Uj3pwmFX2/PADc/mpY6uo6p0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(30864003)(8676002)(53546011)(316002)(478600001)(5660300002)(54906003)(41300700001)(66556008)(66946007)(36756003)(83380400001)(8936002)(4326008)(6916009)(66476007)(6506007)(38100700002)(186003)(2616005)(6486002)(31696002)(6666004)(966005)(6512007)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RiN2ZId1FRWUtXR2VVaUpoR1VHcUlnUUM4OWE2RTBTaFZZMHJjNlFBTnpF?=
 =?utf-8?B?MnlEb3NUbzlTUEdac0MzSUlJR3BzQjNta2s3MWtxZXJ1MkYzRmM2bjJrVlBm?=
 =?utf-8?B?b2h6Q3JkSmhQVHBobmhZTUJuaHVaU1d6SXg1WENsVFdmZDJPUnY0dC82Z045?=
 =?utf-8?B?L3J1bkk5cEZjZStMNkpHNkNydjFUSVNmWlZ5dTZBQkVYaldyTVBTdkxoeVlo?=
 =?utf-8?B?a3g2elArL3Vkd0tJVURuVFUvaGk1Q3NhRllwZzhXR2k0cW5PWUcrSHRvRWN4?=
 =?utf-8?B?OCtqYkY4YjhRb1hDdnJGdzZ4dFNkNFJ4QkRBU0hERzczK2pPZnkwc2V1WHpk?=
 =?utf-8?B?QVc5aFVWK1pwNFMraHhSNHJKaVp2UXBLNUxJamZaVnFqcmF2RjBvTkRGSmE3?=
 =?utf-8?B?NFJJZ3YwWkhQOFNiT0grdDFOd2hpcStoTjBsM1E4ZklzYTJMTzk2ZEltcmc1?=
 =?utf-8?B?QVdJT0xVR1VXL1AzUzJWb1laSVVDOFNvWmt5dHlJakF2MHRydkUvamJnYXFt?=
 =?utf-8?B?OW45VkdkQVFqUnpaTGxBWEFGQ0V3YTJidzYvd2FwZEN4MElWVUZwWmZIOTAx?=
 =?utf-8?B?eXRJVEU2Ri9zTGRqQjJmWEtBeE1FbUJxNi9MdDA3YmNYeitCVlhnS2trUysx?=
 =?utf-8?B?UTN4dmY3Vm55TFFDNFhzd2tXRy9veDZJb1pGbmt5a0lmRDB4aXNydk5kdW9D?=
 =?utf-8?B?ZUpveTJQbFNHTjBiSTBvRG5lUjM3RHJmVHlVdS9RK3UxRkRHL0xqVGlLMDg0?=
 =?utf-8?B?VW0zWFZxYmZvMVhZY24xTE5SVHZQQkprMkQvYVJHS3VmNXZtWitFU1dSOEJ0?=
 =?utf-8?B?MC9UWTZlTVppU1FFaURkN0dVYWJMWFRqcXM5VTEwRmFGTzlFTGlldVNvQXdF?=
 =?utf-8?B?UWpLZVh5RnQwRVdmZkRRN2Q2YVlueWIreE12elBFTXFpVkgzWmZDL2VRMjVG?=
 =?utf-8?B?aFdVbEpLZHRjY3NRaVd3WVpQK0I3Z2x4cDdNZlczbEdXdC91ZEJOS29LMVNQ?=
 =?utf-8?B?ejdad21zbzlQbGRBdkMyT0JDYVFrSnBSaXRsUDJqdERJZVR5T1RLeCtXbVRV?=
 =?utf-8?B?cWI4MWRMZEFBZjFmVk1WQW9RbU5EOHJNVDJxazZGU0F1WlRWeXZxSU1TVkhj?=
 =?utf-8?B?M0czdURidHlYZnJBcmwrakYwUE9VM0FlS0FHczVpSkxDZXhBakhqYmdrcGNC?=
 =?utf-8?B?dzBGU29SRWxUVWxVeGt6Y2ZYTUJ4MzQwMTRabW1taE9vd0lkRlJ3Z09QRlBw?=
 =?utf-8?B?ZjFXZTFFbUc1bFZxWCtGY0x5Ym9iWXFidzRhVWJvWGkyYzdLdzRnZ0hmaUR4?=
 =?utf-8?B?NFh0ejFTOTR6WjI5L2dPOUN5YW14VjBsQnRkd3VpRW56alhvdzNmdlVMZUxC?=
 =?utf-8?B?TUd0cHllT1NhSTIrUndtdFBxKzAxN0t0OHZ0cVpFUUI4eUFOaXVtSGRkNXVK?=
 =?utf-8?B?bU9YYU4rbnNiQ0tEcE5wbzQvb0hxeitWUFFRak8xUWZ6YzJ1b3FDL254UUlv?=
 =?utf-8?B?eGZIUFRnM0RkS2ZXdUplOXVDUm0veElPNHhhZXM5b0huQ2cyQVlUSTcyeXlG?=
 =?utf-8?B?NFYwLzVzOW5PWTVlNmNJZkdzZ0JVR28va21iSGRwYkpXdE1wNHN4dnVVOHlw?=
 =?utf-8?B?YTQ3QlZBSE5lZjBCV1dyd280ODVJUjQ5bXR5YXI4M1o0TVFlaHEwZ2NkVEZQ?=
 =?utf-8?B?ZTkvSk5DY09vakk0SFNlTThJaGtrZ3hjbG5IcS9BeFhGaXprYkhJUEFHNWlG?=
 =?utf-8?B?VjQ2UjY2TjB3N0NGRWNtdVRkNFVPV1EyR2wvN29qZFFsaHNSZkQ2a1dZVUJj?=
 =?utf-8?B?bU9iRXhRWmFJb1NQbWpDei80b2REdC9QckVkOUFlQVR6WEhaMjUxdk9qaUtv?=
 =?utf-8?B?QTJQS3V1Y1ZwZEJsTjh0QjhWS1YxeFEyamhmemxRbVBqV2xhR2VvT3pscFRt?=
 =?utf-8?B?eENIVTA0cmdNWFhQSm5IeWd3ejNwcGJqdDJFemlFMHd1LzZMSS8xcHhkV0xp?=
 =?utf-8?B?RjdpaTBIcEE2bTVrbXpodlZaMVpZZUcyK1RKVzI3cmVmWGRiRUxoNm4rMlRi?=
 =?utf-8?B?ODJwNmRGR21qeFZDVnZheHd3QnBSV3hsWWVKWWcvclNoc1pRQ1ZYNXZNenk4?=
 =?utf-8?B?NnNwNjlnMEZNU1lMUmJrTnRTNC9VWE9Sak1za2dXMkNFS3Q3cXBpYUVNM0Vp?=
 =?utf-8?Q?2BklYSlULVs/W2awq/xsQeNOwZkeoTyXhoivkrFZF2ZU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232142ef-77be-436c-66d0-08dada17d560
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:01:52.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek9mt/+MDrPcAwoJI7XtfCghJQMRArk+l5igZ8v51EN997M1IHuyNy3h+5PpDogOt1i7qxVUU86aI977/YcOCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 12/8/22 11:05 AM, Mathieu Poirier wrote:
> On Tue, Dec 06, 2022 at 08:23:13AM -0800, Ben Levinsky wrote:
>> Good Morning Mathieu,
>>
>>
>> I did some testing and replied inline.
>>
>>
>> On 12/2/22 9:00 AM, Mathieu Poirier wrote:
>>> On Wed, Nov 30, 2022 at 09:39:33PM +0000, Levinsky, Ben wrote:
>>>> Hi Mathieu,
>>>>
>>>> Thank you for your review. Please see my reply inline.
>>>>
>>>> Thanks
>>>> Ben
>>>>
>>>> On 11/25/22, 10:05 AM, "Mathieu Poirier"<mathieu.poirier@linaro.org>  wrote:
>>>>
>>>>       CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>>>>
>>>>
>>>>       Hi Ben,
>>>>
>>>>       On Tue, Nov 15, 2022 at 07:37:53AM -0800, Ben Levinsky wrote:
>>>>       > Allow users of remoteproc the ability to get a handle to an rproc by
>>>>       > passing in node that has parent rproc device and an ID that matches
>>>>       > an expected rproc struct's index field.
>>>>       >
>>>>       > This enables to get rproc structure for remoteproc drivers that manage
>>>>       > more than 1 remote processor (e.g. TI and Xilinx R5 drivers).
>>>>       >
>>>>       > Signed-off-by: Ben Levinsky<ben.levinsky@xilinx.com>
>>>>       > ---
>>>>       >  drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
>>>>       >  include/linux/remoteproc.h           |  1 +
>>>>       >  2 files changed, 64 insertions(+), 1 deletion(-)
>>>>       >
>>>>       > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>>       > index 775df165eb45..6f7058bcc80c 100644
>>>>       > --- a/drivers/remoteproc/remoteproc_core.c
>>>>       > +++ b/drivers/remoteproc/remoteproc_core.c
>>>>       > @@ -40,6 +40,7 @@
>>>>       >  #include <linux/virtio_ring.h>
>>>>       >  #include <asm/byteorder.h>
>>>>       >  #include <linux/platform_device.h>
>>>>       > +#include <linux/of_platform.h>
>>>>       >
>>>>       >  #include "remoteproc_internal.h"
>>>>       >
>>>>       > @@ -2203,13 +2204,74 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>>>>       >
>>>>       >       return rproc;
>>>>       >  }
>>>>       > +
>>>>       > +/**
>>>>       > + * rproc_get_by_id() - find a remote processor by ID
>>>>       > + * @phandle: phandle to the rproc
>>>>       > + * @id: Index into rproc list that uniquely identifies the rproc struct
>>>>       > + *
>>>>       > + * Finds an rproc handle using the remote processor's index, and then
>>>>       > + * return a handle to the rproc. Before returning, ensure that the
>>>>       > + * parent node's driver is still loaded.
>>>>       > + *
>>>>       > + * This function increments the remote processor's refcount, so always
>>>>       > + * use rproc_put() to decrement it back once rproc isn't needed anymore.
>>>>       > + *
>>>>       > + * Return: rproc handle on success, and NULL on failure
>>>>       > + */
>>>>       > +
>>>>       > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
>>>>       > +{
>>>>       > +     struct rproc *rproc = NULL, *r;
>>>>       > +     struct platform_device *parent_pdev;
>>>>       > +     struct device_node *np;
>>>>       > +
>>>>       > +     np = of_find_node_by_phandle(phandle);
>>>>       > +     if (!np)
>>>>       > +             return NULL;
>>>>       > +
>>>>       > +     parent_pdev = of_find_device_by_node(np->parent);
>>>>       > +     if (!parent_pdev) {
>>>>       > +             dev_err(&parent_pdev->dev,
>>>>       > +                     "no platform device for node %pOF\n", np);
>>>>       > +             of_node_put(np);
>>>>       > +             return NULL;
>>>>       > +     }
>>>>       > +
>>>>       > +     /* prevent underlying implementation from being removed */
>>>>       > +     if (!try_module_get(parent_pdev->dev.driver->owner)) {
>>>>       > +             dev_err(&parent_pdev->dev, "can't get owner\n");
>>>>       > +             of_node_put(np);
>>>>       > +             return NULL;
>>>>       > +     }
>>>>       > +
>>>>       > +     rcu_read_lock();
>>>>       > +     list_for_each_entry_rcu(r, &rproc_list, node) {
>>>>       > +             if (r->index == id) {
>>>>       > +                     rproc = r;
>>>>       > +                     get_device(&rproc->dev);
>>>>       > +                     break;
>>>>       > +             }
>>>>       > +     }
>>>>
>>>>       This won't work because several remote processors can be on the list.  If
>>>>       another remote processor was discovered before the one @phandle is associated
>>>>       with, the remote processor pertaining to that previous one will returned.
>>>>
>>>> I didn't understand. From my point of view passing in the phandle of the child-platform device here will work because each child-platform will have its own entry in the remoteproc list.
>>> You are correct, each child platform device will have its own entry in
>>> @rproc_list.  The problem is that r->index may not match @id that is passed as a
>>> parameter.
>>>
>>>> Also " If    another remote processor was discovered before the one" Here this prevented from what I can see because the remoteproc_list is protected by a mutex_lock. Seehttps://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2288  for the mutex_lock.
>>>>
>>>> Additionally the calls to zynqmp_r5_add_rproc_core() are called sequentially so this also prevents the race condition.
>>>>
>>>> I think I am missing something in your paragraph above. Can you expand on this issue?
>>> As explained above, the issue is not about race conditions but the value of
>>> r->index and @id.
>>>
>>>>    Do you mean to say that if we use the cluster platform device you think using one of the existing APIs will work? For example rproc_get_by_child() or rproc_get_by_phandle()
>>>>
>>>> Athttps://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923  " zynqmp_r5_add_rproc_core(&child_pdev->dev);" Here if we use cluster->dev this will work? To dig deeper into this for both the Xilinx and TI R5 remoteproc drivers, I think this proposed solution will create an issue in that for Split modes, the existing getter APIs will not be able to return one of the corresponding rproc instances because both cores will refer to the same platform-device structure.
>>>>
>>>> I can bring up the above in the community call.
>>>>
>>>>       There is also an issue with rproc_put().
>>>>
>>>> If passing the cluster platform device works for the above then rproc_put() should work correct? We can test this on our side as well. That being said I can bring this up in the community call
>>> Yes, using the cluster platform device will work with rproc_put().
>>>
>>>>
>>>>       I think your description of the problem is mostly correct.  The intermediate
>>>>       devices created by the cascading entries for individual remote processors in the
>>>>       device tree are causing an issue.  The "compatible" string for each remote
>>>>       processor can't be handled by any platform drivers (as it should be), which
>>>>       makes try_module_get() fail because r->dev.parent->driver is not bound to
>>>>       anything.
>>>>
>>>>       Looking at the code for Xilinx's R5F support that I just queued[1], the simplest
>>>>       solution may be to pass @dev, which is in fact @cluster->dev, to
>>>>       zynqmp_r5_add_rproc_core() rather than the device associated with the
>>>>       intermediate platform device.
>>>>
>>>>       That _should_ work.  It is hard for me to know for sure since I don't have a
>>>>       platform that has dual core remote processor to test with.
>>>>
>>>>       Get back to me with how that turned out and we'll go from there.
>>>>
>>>>       Thanks,
>>>>       Mathieu
>>>>
>>>>
>>>>
>>>>
>>>>       [1].https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923
>>
>> I have an update on this.
>>
>>
>>
>> I tested the following using the RPU-cluster platform device:
>>
>> test 1: RPU split with 2 core
>>
>> test 2: RPU split with 1 core
>>
>> test 3: lockstep RPU
>>
>>
>> I tested with the zynqmp-r5-remoteproc platform probe using the (RPU)
>> cluster platform device instead of the core/child platform device. When I
>> used this I was unable to properly use the API rproc_get_by_phandle() and
>> there was _only_ an issue for test 1. This was because each core will have
>> its own call to rproc_alloc(), rproc_add() and each core's remoteproc
>> structure has the same parent device.
> 
> You haven't specified if my proposal worked with test 2 and 3.  I'm guessing
> that it does.
> 
Sorry, yes tests 2 and 3 work with your proposal.
>>
>> This results in the later call to rproc_get_by_phandle() not behaving
>> properly because the function will return whichever core had its entries
>> added to the list first.
>>
> 
> That is a valid observation, but at least we are getting closer.  The next step
> is to find the right remote processor and I think we should look at np->name and
> rproc->name.  They should be quite close because rproc_alloc() is called with
> dev_name(cdev).
> 
> I will look into this further tomorrow morning if I have time, but I encourage
> you to do the same on your side.
> 

For the case where the cluster is in split mode and there are 2 child 
nodes here is my update:

1. The rproc_list has 2 entries as follows:
	
   as expected each entry has the same r->dev.parent (E.g. the cluster node)

   The entries have the  with device name rproc->dev name 'remoteproc0' 
and 'remoteproc1'


	
2. For my use case I am trying to pass in the phandle of the core node 
(child of the cluster). If I pass in the core node then 
rproc_get_by_phandle() returns NULL because the r->dev.parent->of_node 
does not match. This is expected because at rproc_alloc() we passed in 
the cluster and not the core.

np->name in the loop is then name of the cluster node in my sample 
device tree that I booted with that is 'r5f_0' where the cluster is 'rf5ss'.

If I am trying to get the rproc entry with name 'remoteproc0' and I pass 
in to rproc_get_by_phandle() the cluster node's phandle (that is of 
rf5ss) then the API _does_ work for getting the first entry from the 
rproc list.

But If I am trying to the second rproc entry (dev name 'remoteproc1') 
and I pass into rproc_get_by_phandle()  I will still get the 
'remoteproc0' entry because the phandle of the first entry also matches 
in the loop.

Thanks
Ben

>>
>> For reference I placed the logic for API rproc_get_by_phandle() that loops
>> through device and the rproc_alloc() line where the dev parent is set:
>>
>>
>> Here is the getter API where the loop checking the remoteproc dev parent is:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2109
>>
>>
>> if(r->dev.parent&& r->dev.parent->of_node== np) {
>>
>>
>> Here is the rproc_alloc() call where they set remoteproc dev parent:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2448
>>
>>
>> rproc->dev.parent= dev;
>>
>> Thanks,
>>
>> Ben
>>
> 
