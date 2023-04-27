Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39F6F0C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbjD0SrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0SrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:47:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93330E8;
        Thu, 27 Apr 2023 11:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVOJRScgZQ/A9f8Qi0s/S5UqOCW576I2RwXYMCOQ3+YtZ3WE4P5DvZ74LG2nJTQiJS7+QBpOEkN705889nlPCF4sO+Qkxo7GRbcNaBCN9OZOI93WF90bLlJ6CLcaOVJJRtDmLB/EyRK923UTTV1oWgZdgkk5KwFEdJsFgyX7gdzkrigTKh3EYbN5EaPfpUVrqZNvPbDy2qlUcaafOQDeF6NiBalbQrUtY6AiXmwNa7OrE2yiNULIYMbi2mNIIDg9rL8OmSVDwXlhNN7QlmD3loRiDEaoON+oWwcRC16KTfAtghSEooPqsftteDtquyhFE0zkjOv2d1yhDBwlNFKvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAnK3/CsJVg2dGZlQjIYSsk554Yht0pZ8cT+m/t9sxs=;
 b=LnylHa51dc9nt10GmfZ5fGAlvwOCyHapmoloE8QHbAi3GuNq+p6djJ+GqKWPviswdGPfsKJs1eA6+ce8jgKc3EKNVklb7KyBjwMGjxPOH6rg84xHYo49SPwLndAvFVikHb14fl5RH+Z4zptZOL6/Rlhi6JkKp6W1QEJ5LhjOMP0k3SsjwvqLocoVwC1/N869wmLEfUAs5mY1C5ABznPBy0n+ukBQyeTZQqy1RTlijN8KhjQJDxojYBpC4nZWvBuW2UGc7klN+PbakqzGCCxwRa2zFDKWX7A7XmTp6lb4wMBt0CeV6k2hsL6AwzKkMPHOag5y+0Ln1Q3SSt65Y1z6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAnK3/CsJVg2dGZlQjIYSsk554Yht0pZ8cT+m/t9sxs=;
 b=frmRUs481kfIjBHQuKSBYzfSIUzWtQjR6b1/QNNfJ8ups7qr24bpKngGACCyfr37QyuZFpGQpeuVcWY3RUVPzvOw7uOhKjnjpc27Si5DZgrS8vsd7P7vK3iFXQNa6JRrmmFnOgkZ4RESG7dWSQo9Xx3gOK7poi6QaoStKqdZwTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7237.namprd08.prod.outlook.com
 (2603:10b6:303:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 18:47:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 18:47:09 +0000
Date:   Thu, 27 Apr 2023 13:47:03 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZErDJxLszj0ZRHXa@nixie71>
References: <ZEf0RYdD5jhE9JEk@nixie71>
 <20230425164903.610455-1-tomas.mudrunka@gmail.com>
 <ZEnErxfnSn2JOpvm@nixie71>
 <CAH2-hcLOA0ECg7ubKh_r9BryRuGPjJ1Cv1ErUpMmQ+Yag5qnWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcLOA0ECg7ubKh_r9BryRuGPjJ1Cv1ErUpMmQ+Yag5qnWA@mail.gmail.com>
X-ClientProxiedBy: DM6PR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:5:337::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: d82840c7-2966-4afa-2e91-08db474fce20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ocBI0yFyqQ8y0rQY0OXcKSY7uNBb/OJlL6bvbpSn+x6WySp7Wdhn5JOkMlrHeoCpWYkGgd6KSp9WKklaP9vcK2FHgOt1fLbRwMO/prPCkIshaAwMIlSyE17CRjt/Bnk/pYz2vVapLHc6ncdH4LpHMEoHauvQhKP2Y2O6RGXGp83xeXvUsp2Nw8mZ4jSQqSPuMuKKzPHMQ82f84baJJbGXLPJNvArpd+Iz0o9mypdoxIdz1w2/a0ftAvl3Ja3zVRY/QcQIRHTWftlw8Sb5yBPf+LvyaPx13CHmvRPdDZsDL+/z6CjGGw6FZKVIBmPw1xGlcsyNLCO3SiCFnG42PywzSwTycvkgdNaOLPP5zjGLmcSX3X9gCL5R9XG2IhJOBTz1uwqrZVSvlemZnkY1bllOngUpZLO5l+wPhyDwaEFLG80krA/VC7hTKn9W3SRVTY+v0kN7Aig0r8Ax8/oofFcBQs67rCe8pWejblcKtG27f84+IDWV4oaw/R2VrKBK84e4OXv3Jgz1XxIVB92gSIIoA2kPFrJQyOAkYE4yLAicOKmOK74aOHdYFwhF3IK9DA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39830400003)(346002)(136003)(396003)(451199021)(6916009)(316002)(4326008)(66946007)(66556008)(66476007)(186003)(9686003)(6506007)(26005)(6512007)(66574015)(83380400001)(38100700002)(8676002)(8936002)(41300700001)(33716001)(5660300002)(6486002)(478600001)(86362001)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRENk9wNWtHNm53UHFrTHlPVGg1NHBuZHNvTVUvVm9sYTYvWW9tbHdtNUVE?=
 =?utf-8?B?VkY4dnE3aUFMbHo0R25XYVlrR2RMdzRpNjRITGp6eVRGekpYUWloK2ZONW1B?=
 =?utf-8?B?cGRoQ2ZCNEJvYTM3TWdBUmhyTWNEMlpQSU5DRlhTWW5BeUk1dGhjeEdON2ky?=
 =?utf-8?B?VUpJUlQ1eEVzRlFoWUhxdXRSUm5UL1BYV1F0MVU5Sk9IenZTL3l1WjhDSlM0?=
 =?utf-8?B?bDVqWCs2Tk1YSGszRy9iSjl0SzV1YUFteWhmM0ttOVY0WFBsVG5YSUlQU2Nw?=
 =?utf-8?B?OEp3ekNqbjVKUW9QSS9YWGtEd2QxamVkY1RoT2d1ZG82OGdiS3NXaWx1VmZQ?=
 =?utf-8?B?aTh4QjZGemZhT0YxdGtKenV6QlA3VmRJRHVqNnk5c1pLU3l2L2tlWjRVV21q?=
 =?utf-8?B?MzdCWjIwZExPQ1dkZEtjR0srUUNZZnNYZ0NxQXhPbDBGMyt3UGJPSjE4ZlRY?=
 =?utf-8?B?eUs0NDFOTjNlam5JQk4yL1VJTE1JNGpleUNaRlMyNEV1dWRBVEM5R1V4R0E5?=
 =?utf-8?B?RHlRYzBRcWdBSnd1d2cvRWt5Y1gvZDRpQnZjVkthMWFWYmtTdklMNE4yMkZr?=
 =?utf-8?B?YURmbHlZdjlqNzhXWDRONGNZc0IrNDhzcFpKa05VdVJDdmFkQVhkVnNYTDd6?=
 =?utf-8?B?VXpYMU1od1VmRU9mRmtZY29HK1IvcGIvVGpOU0ZOUUl4a3d5aFladjRHSFRJ?=
 =?utf-8?B?Nk1jK1RNUW11TmhlbjFHZFR1T3pTbnd1M1ZnaGhicWkzS2RNVzhxQzNCYVda?=
 =?utf-8?B?NDRsRmlOWVBwSnp3blVNVjFxbzA3bmhJc0haMms0eWIxa1hVcTRHd2QyU3Vp?=
 =?utf-8?B?NzBlcU5pUVFtYVEwYTZoUXAzWFVSNmEwWnRPYkZqTkhrci91M2Y2a1huVnNX?=
 =?utf-8?B?RDdkV1FTcnNLSHdpRmRWTktoaWRlc2JndTk2TnBwTm9sTVdzOXMxbnR0UnNJ?=
 =?utf-8?B?MWFQREhQV3BxWVhvNmZLeE0yU05tR0Y1OUhpNVBqMndTaTFXTEhuVnNma3lJ?=
 =?utf-8?B?NW5QTlJ5dGVrdHlKQXEvbG1yRHI0QjUxeDhWajB4eDVJNVRlclJENUl5WElv?=
 =?utf-8?B?Wmp6cHNVUk9VK1BVUEpWRU5ydHora0VRa3RkUVp1ZWxWckgyK3N6alprRUFx?=
 =?utf-8?B?bVF4UlJ0Mk1lazVZZHBHUTh4TjljdE5RZTB1VkFnWHRIZTFyYWp6dnlLQnFS?=
 =?utf-8?B?YW1FS05BQUxNL08rUGY4SW1TRThiMHQ4K3JGYWIvRFhOQVBPSUh1OGZFZWN3?=
 =?utf-8?B?d29HSjdkMFFOUjM3VjlSQkQ1WVR0U0kzM0srWitLNytkckRnNkJjdy9INDZB?=
 =?utf-8?B?b3ArU1R0LzNZWXdUTk5ZclE4Vy9yQUxHVjdXTExEL1ZNUDY1N1FXVmJJekZB?=
 =?utf-8?B?aXpHU2hLM3VGaVl6VklYRUN2dkZTZFNmN0x2SzVxd2UxblRFMzhEYUtYVWlR?=
 =?utf-8?B?d3M5OG9BeFNmTjFFcGNtSEM5MnJuMUVnS0dIT0twd0owZmw2SEYvTDMzZVQ2?=
 =?utf-8?B?RWg0My9qOWhWTk5sNGIzZzkyd0E4ckZMSW9ldjM3V1NLekNqQW55a2V5elR5?=
 =?utf-8?B?eHY0RUYrOHIzdlRkZGN1NkZ2VWR4T1VHNVJZb3VnOWlvSHBxamJRU0ErdEZ5?=
 =?utf-8?B?MTdLdENHTm91eGdraGZUSGJDQS80MkdGRVpuZG9zRGxCTGlMbU9lSnBCNU16?=
 =?utf-8?B?MXFhVWM4L3dsbW5rVUU3Q1RQSFdIMVZ6UkNCd0hQUzFoNGxPa3VtOXplNk1t?=
 =?utf-8?B?bUpRTEFNdURILytoOCtubVh1amZOSjZ4Vmt6SmszNGx2azlRNEVCN2hQSHNH?=
 =?utf-8?B?K2wwb1NIamVzbTE3eHVSOWEyVHY5dnNFU1R6WVB2VmlxNTREVnZiUWdYb0xx?=
 =?utf-8?B?Z3FPSm1mMmRTQjdJdCtyZi9vNjR3c0dJMTYyd2c5RytwYWpyQjI5MXBkeHI0?=
 =?utf-8?B?b3p2WEZLd2VBTEtEaWpaKzVVSFFnRGwvNWg1MFh5QXRGVUV5eWNEeHJCdVdX?=
 =?utf-8?B?L3lpMEw4NVRNMWNSUUt6TEdTaHJrMnYzeGRhMm1LSUVLMDFTM0d3WkE1akRr?=
 =?utf-8?B?K3h3MHRTTCtQRDEwVkxkWlZCU1hSSjJuWFczYzlSdzFmM1NxUlRDZE5IYXNM?=
 =?utf-8?Q?ixkTg04Z3p/9ffRbC7wtDGamo?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82840c7-2966-4afa-2e91-08db474fce20
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 18:47:09.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAdXmmz5O+nCxts0ZJ01onCJzF49IkPdcCu1bXkqUvp18cXyCenkOtEGOa6z0dlsDnQlig3oQqnUXj35Syvdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7237
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Thu, Apr 27, 2023 at 10:13:22AM +0200, Tomáš Mudruňka wrote:
> Hello, thanks for your notes.
> 
> > This is the right idea. I am sort of splitting hairs here, however I
> > think it makes sense to place this read before the IRQ is requested
> > and not after.
> >
> >
> > As written, there is room for an ever-so-tiny race condition wherein
> > the IRQ is asserted just after it is requested. Before the threaded
> > handler has run however, the new read in probe swallows the IRQ status
> > before the threaded handler can read it and react to errors.
> 
> In fact i believe quite the opposite case to be true.
> If i read before registering IRQ there will be ever-so-tiny race condition that
> would allow to miss the edge (exactly the bug this patch is fixing,
> but limited).

I thought the original problem is that the IRQ is already low by the time
the driver loads. Since a high-to-low transition (i.e. falling edge) is
never witnessed, the handler is never called to read the status and allow
the IRQ to go high again. Therefore, key events are gone forever.

The concern you mention is simply that of not responding to key events
until the interrupt handler is registered; there is no way around that.
Any event that occurs before then is off the table. Instead, we can only
make sure that none of those prior events place us in a bad state.

> 
> In the case you describe the worst scenario is likely that the interrupt handler
> will be called only to re-read status and immediately return on this condition:
> 
> if (!status) return IRQ_NONE;

Right, I am simply saying this is one key press that could have been
preserved. As a matter of principle, once the interrupt handler is live,
you should not disturb the precious read-on-clear registers on your own
without concurrency protection. It is much more common to clear suprious
interrupts and _then_ make the handler go live.

> 
> > Also, I think you should at least capture and evaluate lm8333_read8()'s
> > return value as is already done for the calls to lm8333_write8().
> 
> Well. If you think this will bring any benefits, i might as well just call
> lm8333_irq_thread() instead of lm8333_read8()
> Would that be acceptable solution?

Looking at the datasheet, it seems this devices builds up scan codes in
a FIFO. To protect against the rare case in which this dummy read includes
actual data, perhaps it is better to call lm8333_irq_thread() instead of
lm8333_read8() so that the FIFO is flushed.

> 
> Tom.

Kind regards,
Jeff LaBundy
