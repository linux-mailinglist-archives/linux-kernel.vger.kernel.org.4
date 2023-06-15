Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF15973207E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjFOTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFOTtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:49:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E94268A;
        Thu, 15 Jun 2023 12:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXEfhRm6IYWJk+xaj4m/sSgCWA0W+ManIzPn+HgglihilMM9c6/IV8Ow+stdztylFDtHGWZe7LO4gr4oJ2XQQvgpJOfVdXWO0SHvKNLQy79UBcQpuCP39lfEyHCFABSuYjqxRoqG/dUG6iyclHVGSH+oadyJgyLR5hZHJbJMSzXNl8jVWtDiBzuaUDK0rEjRGkhqtOhFFExb2FNslIborz/58FlGwPkX7g869fkm7/bdDJkOLZgADcgcPpsHemCmKStteKt2wFgkI5W9phJhXZTlSfv1Lod5wPTMfCKYWLqEAm/No6b1RHnXo0UFZtz0aZHeUwDX3mK7Y072cq+4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afrlw1DJxzQS4TI/HCzNDNYGHu623RQS9A0t4NqAQ4Q=;
 b=QZ1neN2SYGZVKaYpxyzNl+yG91g4RYAIxpkZOrmI5ihOa/gB7Zqx+Ew6lQXzysvCA/slv0hn4ar9ooNJnVnHoH19karNmLstfZ2ITLr/1sGUHcXDAuXcLef37ijhZB04PZaLdZtLeiHAWY9xcNDDKe1hVBu9qUgD2qgdCqFjCUHsXTZbx0sI6gcP2kxBks3vL0C5HkXft/J8cvXoKZ5/R+l4AlQSXXs8niWwDuNhvKzi1aVvlqdHdywfRqIfRTOSuu7iMDO/6iZO43x3sWebsXlhWZnEYL7aUwCrZc8iR7e5G8pN7nJt39CFGKe6XQTahW/57ljR8eR+2dpBBCEM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afrlw1DJxzQS4TI/HCzNDNYGHu623RQS9A0t4NqAQ4Q=;
 b=qEgkercnaaQD0kt8pI0SV/oNAYYbE516vpOMr4sniYXkMWTsUiU5JmV0jBa8lkQWmRsXXSob4THP+BEug3oe8B68vur1kAfI8ioUPFH0OOHaZa3q0KImDwzDexUdhQWQ246Va3J1CAVG30F92FRr8Xm2EoKLUugQVJTPR0InTSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by PH0PR08MB7242.namprd08.prod.outlook.com (2603:10b6:510:a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 19:49:38 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::e6a9:c49:b451:962]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::e6a9:c49:b451:962%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 19:49:41 +0000
Date:   Thu, 15 Jun 2023 14:49:33 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Input: support pre-stored effects
Message-ID: <ZItrTTAhsgNRP12k@nixie71>
References: <20230612194357.1022137-1-james.ogletree@cirrus.com>
 <ZIfFgJJtGCfyIne4@nixie71>
 <5CD75646-02A6-4175-9176-A8DCD059085F@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5CD75646-02A6-4175-9176-A8DCD059085F@cirrus.com>
X-ClientProxiedBy: DS7PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::32) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|PH0PR08MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 36609658-c985-46a6-def7-08db6dd9a88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmtxI9VtHOzRhyuAxzSGfNL34mH8bPveZP9DD2LXlUJOR6maiDeTDpIYgToX9G6PrjxLggySqI1rGVmH5oZrZtvR9C1LVjnlKXs9JvujfNobq/vlJOkxQLyNPQ09NxfBnrjMENQcW//OVAYBjLpI4AB044pdpvwsjM4qcDfC0GuLZrkZcCJqh+f+AjtQicoaAcheNqlVwC4hKkbguS47yIWoPwi3rz0pQdnyM5iDDIWv/NnzQmcrgUstd3eY6xlb2tciPghdzOhyaiFeeUxThliVZx45pVuYmOCJnVitm7eaq656/V9bWUdm7ELLBxNwGlrcQF2/CTlVwSozFVPfJG7nHxvqjG3VNhpClH7PodMc99MDlvNnHlaale6ScLGM8qnUpGuygYBIdDjDkSMzavQf9KZPD0glzKM2jjdGuNPrQN7K8tXqQqW3g7z2Y+uUACXOxOWK8M7zbTrvmSf9QyP8UvUdjwttT07EDOSZnsa12ESmCZLqHk1on4zAQGBb41X79y5nVKM4H/HBHNUiJqGIe05Ywhhj/H3FFDCOV6XHEYYk1fZvZH71VzPdvhWYJpV7e1A669SKIonz05BAJiuSSMRoZEx0ten10m/RGhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(136003)(376002)(366004)(396003)(346002)(451199021)(8936002)(83380400001)(41300700001)(8676002)(6486002)(2906002)(6506007)(53546011)(9686003)(26005)(186003)(6512007)(5660300002)(66556008)(66946007)(6916009)(66476007)(86362001)(4326008)(478600001)(33716001)(38100700002)(54906003)(6666004)(316002)(95444003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEI2ZnFhcVR2VHNWb2dmcDRYU0IrQ0hjMnNiczMxQ3JvNk5Qc1lNUW8xRmJX?=
 =?utf-8?B?WHlodTFiaDZ1MUxMQVVlL2xtODdFcEpxUjcvbmZCVGZpd2RQaHI2aG56RDlm?=
 =?utf-8?B?clRHcTBhTXAvandCSjR4RVAyRXlCZ1pLVlJIUVpiWHlUbDVRbmpoNWI0TDBK?=
 =?utf-8?B?TzdGb09OWDI0T1czdTFnbDczYjBDK1p0NVpxL1JnSzdUUllvT1NLMXd5U2FR?=
 =?utf-8?B?Y2E3WXlIeXJoNlBZRkoyZllseXRydXhTQ25qRU5uaFJMV2lYeFE3YWRRbFp5?=
 =?utf-8?B?WldIdEluYWRTNWZHTE5Fa0c5bmlBOVNqNldkUU9ROGhiWDNlVDFoeXhRaUNS?=
 =?utf-8?B?YXc4M2Y1cXVOQkxrTitIU20xU2dpRUovOExXWVJhRFhMRkEyeUUwQ1lwV3NT?=
 =?utf-8?B?cmQ5d2R1QVVQaFRTRlhRaVVFWWhHcThaRVZxSUk3Ly9xeEtUTmpzN1ZEeXIw?=
 =?utf-8?B?WXhHNHNXd083ZE8xRTJGRHh6ZjVUc3YrZWp3bERvYndpTDNPSFJWcWRGM1h3?=
 =?utf-8?B?NjBNV3pJeHk2elo4bjh0d2IvamZObThPZ3pwYWVzTzhtRkpFR2R4RHBGbTA4?=
 =?utf-8?B?T0QvKytXb2JrNktqbVhhNENWUDNkaTdMbmhpemZmTGwyUFVTQjBScTc4Ymw5?=
 =?utf-8?B?SG5XSTIyVjRja0FETEkxNEFkOVFzU1k0QnNmYnJRcE9GVVpjZCtNK0Vibmho?=
 =?utf-8?B?czZJdWtqVklmN1htbkk1d2theHNYMDloS3YvWDZZTURlQ2F5U2R6ZnZDN24x?=
 =?utf-8?B?bkZMOEczRDBPZVRiZHZldGRtL1d0MTFzOVpXZFRaRUZKanpKZ1E2ZVo2S25G?=
 =?utf-8?B?Z2VHN0VDNllpNEdRUHp4bTlBbUhoTGMrZTRDMUZGWnh2MXJsMnFyemk3M2Qw?=
 =?utf-8?B?QkVLN2plKzMyanZ1ZmRwUXpKajEvamNGZ3NKWHRkV0dsQ3JkWWJXMGJaM0JX?=
 =?utf-8?B?cnk4bFpnYmdneWx5SDgwL3RFWmtFUkxmaGxUMFVxbjZQT3JtaUk0cC8yZXBr?=
 =?utf-8?B?K2s4ZCtKWHpkR2VLYUhNVko5SVMvRFhYUXJpcFovRDM1SmtxbGhwSW5WM2px?=
 =?utf-8?B?R21MTDNPUUl6cmFhWi95N1BST0svZnh0RnhsY1hmdWt2WjhUaHM1elhUZm1X?=
 =?utf-8?B?enFRTjY2Umh1V0dZR01YQVR3WndadHcrTHEwQVVDeGI2WnNNdFh1NC8raXhN?=
 =?utf-8?B?VDdKRHVDd1JCM1FvMUVKK04zRkZRTFJLU2VwU1ljTkJ3ZENWNTc3SklHZWl0?=
 =?utf-8?B?TVFiUDhBVGg0MjNIaG8zaU9oNC9JeTRxSjFhZXllMXFicTIyUHFPcUtON3Jq?=
 =?utf-8?B?V2Y3U2NsODZrUlRkKzZqVXVSY1ZnbjNSbXV0WXYrYThVUEVvL0VHK1dWVmxE?=
 =?utf-8?B?anozcVhLQVUzalhFcjd2T0VtMVY0YVdkZk0yaHEyWHp4TW4vVlU4SmtYN2M3?=
 =?utf-8?B?Y0dJaGVQVjdJL1dwcmlvRU1GSFUrZ00vY0RNSUVDVHcyZ2ovSEJlUDZPOVor?=
 =?utf-8?B?V2twWm9YcVB1N2p2UnBFcm4rVDUrekpHdFpRNDNOTFFGZHVIMFlYTjlOa3p2?=
 =?utf-8?B?NCs0STd6Q2VWQVprYXNQblV4ejBEU1I3NzhhenBQSVNJNDNvUVpiL0Q3aDFN?=
 =?utf-8?B?RFNXdUtEcFBUUy9WWnhlODdTTmpVWk9FZHo2YXBYTGFOYnZnMngwRnFiY2xr?=
 =?utf-8?B?eW5QY1QwZU9kZXlacWp2MWoyeThndWI0Tk1wT2xYblJ5NWpmbFZFMms2R0R0?=
 =?utf-8?B?ajRSeVk5eG9IQW5xT0tHb1ozZjIzMks2WHNEUVpNR0EvYmVJZy9URFBmaGFx?=
 =?utf-8?B?d3QyeEt4VFBKV0xETDg2aFJsTm1vYS9qcHh0MGRWcEtvRit1TWw1N0ZXeXpp?=
 =?utf-8?B?VDZCclNYYXcwajM1TkM3bW1wQ3lYanpDR3czdFh5NE1pYXJtMTN0RlFxL0RJ?=
 =?utf-8?B?bnpkcUNNNGNHZTI0YWFxeEZISlM5dmc3V2c5VjI1RFdKNTh1QlQ4RFplZWRh?=
 =?utf-8?B?R3NIN1l4NFFia1dFcVp0dHYxaXErVjNLVXBwc08vRGZsWCtDWks2VmV6Njl3?=
 =?utf-8?B?ZFdiam5vcTE0QWF0c0ltRTNQQ3owKzcxM244SlFFMUpac2Q0ZVl3Y0o0MGJC?=
 =?utf-8?Q?l5HnWV1f8WP5Xck9PrMxL7+tx?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36609658-c985-46a6-def7-08db6dd9a88f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 19:49:40.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVpQM3sDRFp7AAeCs/TlQ5M7Q2BRRysUaSbZZI3V0RHu+42TJ39Vk4slUJEmpF4VML/OP0NTzqMugtagNtyQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7242
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jun 15, 2023 at 06:12:20PM +0000, James Ogletree wrote:
> 
> 
> > On Jun 12, 2023, at 8:25 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > Hi James,
> > 
> > On Mon, Jun 12, 2023 at 07:43:57PM +0000, James Ogletree wrote:
> >> At present, the best way to define effects that
> >> pre-exist in device memory is by utilizing
> >> the custom_data field, which it was not intended
> >> for, and requires arbitrary interpretation by
> >> the driver to make meaningful.
> >> 
> >> Provide option for defining pre-stored effects in
> >> device memory.
> >> 
> >> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> >> ---
> >> include/uapi/linux/input.h | 32 ++++++++++++++++++++++----------
> >> 1 file changed, 22 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> >> index 2557eb7b0561..689e5fa10647 100644
> >> --- a/include/uapi/linux/input.h
> >> +++ b/include/uapi/linux/input.h
> >> @@ -428,17 +428,27 @@ struct ff_rumble_effect {
> >> __u16 weak_magnitude;
> >> };
> >> 
> >> +/**
> >> + * struct ff_prestored_effect - defines parameters of a pre-stored force-feedback effect
> >> + * @index: index of effect
> >> + * @bank: memory bank of effect
> >> + */
> >> +struct ff_prestored_effect {
> >> + __u16 index;
> >> + __u16 bank;
> >> +};
> > 
> > This seems like a good start; I do wonder if it's useful to review recent
> > customer vibrator HAL implementations and decide whether you want to pack
> > any additional members here such as magnitude, etc. as is done for periodic
> > effects?
> > 
> > Back in L25 days, some customers would assign click or tap effects to one
> > or more entries in the wavetable and then use a separate digital volume
> > control (at that time exposed through sysfs) to create a few discrete
> > amplitude levels. Perhaps it would be handy to bundle this information as
> > part of the same call?
> > 
> > It's just a suggestion; I'll defer to your much more recent expertise.
> > 
> 
> My thinking is that ff_prestored_effect ought to be for effects being used
> “off-the-shelf”, and in such cases it would seem appropriate to defer to
> firmware for the effect design. I think this fits nicely as-is with the other
> structures as it serves a clear and distinct use-case. Otherwise one might
> just add these two members to ff_periodic_effect (or every kind of effect).
> 
> I think the current predominant method for setting "magnitude" for these
> pre-stored effects is by using the FF_GAIN event code as a separate write
> call, so I think adding a magnitude member would go unused, if I understand
> you correctly.

All great points. In that case:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> 
> Thanks,
> James
> 
> 
> 

Kind regards,
Jeff LaBundy
