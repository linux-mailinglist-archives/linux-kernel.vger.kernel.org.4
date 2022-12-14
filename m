Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47F64C5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiLNJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLNJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:17:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA521D648;
        Wed, 14 Dec 2022 01:17:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiE/mmP3YzFdg8YjoohNRtMNlwAHQzUZ2OsSEDlyIy7g7N80BHfY1p8O01Gm9UrhLU4lrtckhWfYm0l678xmKAsnDoVAthJpKKDTmUcmEnkVWpRFfRN+9dM61LQ5LtyKCo6ojR68uY0BVzXIf5H+HUQKS+/CDhkbajse3FQzyRIsTCIg9uKczHFIsJIvwnSP7C9jibyTTbonTZTGx/zZqOrT7V+zhYLrFnUNT4bfgQPXAqKM1lLuHdUCW7Gr94I/ereO9G4UUJaBYM1ZuoJiZ21FOJY7JulApToCwAD6iQ1093kAtMEOZfBOhR4rFh5AjVqCWxTA31t4WiCahZX1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNEBkLSVvKcpin4VtmcYFGEDsFF4SwtY9NhrZdCEsG8=;
 b=ZknGW4MuhtLGSaH10oFdsclUYL12N9LJkjF70qyOjLHs8LQpzrNrIdhO2freS8Nz1nAe/4c2NA3CpQTOjPLrj9KLRk+1Fym73Qxrvkf4djU+fkHX0DZYAqGsJO2szZ7O7vFcc5cv7bbI+mVR8VxdC4EA61t54EC3WayNDdKZXMgCTlA3OIXLr/2JRSEXw6SrYFfRrjUDli6GRyVgUK4sc33GJalMFtxchMRjEPLjQKxfNYg+mfRVioIrwKB8MB/K+AMqSpdRHsvOIayw4ULb57G7ijQcY00bHsZNDpG91GW8PUlzEHGJNYFKIWo0BRCKtNJIVwczP2G/n0yzHLVYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNEBkLSVvKcpin4VtmcYFGEDsFF4SwtY9NhrZdCEsG8=;
 b=s93hpoyok7HTI5h3+MU3OGApvDfIrXg7MyhSOjlinfB36rt2MNAD9OHWCWhMZOYlmEly7VFWKY7rcnS3ub0TmCWuB/1QWkdoFjClyqV1VfsOYg2l8rvcQh8jMjEVZgyK0D9DfGZqewVPIE/LBTfY1AvOHCtL45eBQTH+Dt5fpmufCj/f74JVyo2/2emgrPB3lUER0Mj3cTlpKuWkiFdbFvv7Jt/TueITS21xUe7UHxYDfbcoTnSa7DSdZkBT9Zg061TLwES66zpWlH5RN4XYdAhxx6iatiGmCWAYX2lodHNunuvx5q+ikYtUG18dRlPoAzoMuXEF52VqQrFHU8uEGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 09:17:33 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 09:17:33 +0000
Message-ID: <c5f24a60-2756-dc99-ee48-99a657a9626c@suse.com>
Date:   Wed, 14 Dec 2022 10:17:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] add hooks for usb suspend and resume
To:     Puma Hsu <pumahsu@google.com>, gregkh@linuxfoundation.org,
        mka@chromium.org, dianders@chromium.org
Cc:     albertccwang@google.com, raychi@google.com, howardyen@google.com,
        leejj@google.com, hch@infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214081456.714859-1-pumahsu@google.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221214081456.714859-1-pumahsu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db0584e-2bb4-4a2d-f45b-08daddb40701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfQXj3jtNGrqTSBoo0JWTasc4H5LL2zejvl2qbIzWoYkdUl/6gzUa9eO1a2GpVCy6fZlc+FHVVzH+wUOzdGmKWWvvUET8O04ljY2LdVhQG+7ZEBIXkSrusnUs+KRQgebjBw09mb7wBL8S9CUGU9lyqOTDSj62jvuN9w/f/AokwGvX7HPLNQAK6WtBSHCOC1wYaZ2rY3IgAPEzHVgN/+wkW+pCdqYQiNzBPAoWOVvP9JIdcwDjpDj876K7R6iqLYnQMli3Ybzp1fsk/VineUXBHdkC7ZMoLZiwm0KjWiy6YLVKFmW9/rxSjJXIJZgqefFbALrWA17s64cVoEsZ6m9ByZmExBjXBKG6hIiyZ8WOBQUySZbe3WmzIJbqszWOTyr5fHGQ7E8O/zIKB7w67QIsD/8fZf0S4lUzBczTRqLG4519ZJER7ga6hd0uLG6jUxihE5I2VaQ41c1+DE1r0SBaboQ+d5yvh6ptxMFr37Yh7qGbTQSJKy0Q4TjEknEtn8x6/HEfMFltBJGiYhn7qVlxT7PlIrLg1Mnpx5CUpe/6J7p2dCswVB74hA2cMU1fQgJYX09v9k5qm7nNRirz3Ki7R8SKWjWL68MzQsx7L1ccKzaJd6gFnNuiqJq8EkdBdAyDoa7TVfZbOv8NA8+cngXB+Qep3//RTTjvi4SIyT7CZmvAgTm68IK6606ik4QNtbehc9PnVcRF5IJDdoa535Tjl/ikO6ggUV1vAn2QvUFHc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(31686004)(36756003)(8676002)(38100700002)(66946007)(2906002)(15650500001)(4326008)(66556008)(66476007)(8936002)(4744005)(5660300002)(7416002)(83380400001)(31696002)(41300700001)(86362001)(316002)(6486002)(478600001)(6506007)(2616005)(53546011)(6666004)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEUwaG1IV0Z3dVFoQ2tIb1h5QWs0UlRsd2g0eS8rcVZmOGVsOGYyMDg0ejht?=
 =?utf-8?B?Qjd2aVJwcUpmUk5adHU3MUE1dXlGWlhCS0hOeUZyVERJa043S2ExQVVCUXUw?=
 =?utf-8?B?L2VBTlNoYjBWUXUzcE5lRW9VT1ZaenlRUStlaXdDQWM3YUlodGFpd0l5QTND?=
 =?utf-8?B?anJFZEIwdGh1bTlodEFYeERiVlJNdk41TENQSzBnaWE5TGtyMTdhWjEwaUd6?=
 =?utf-8?B?VXR0RUNWWUNjK0FhZStHbmg2OC9jYjZPaC9LM1pmcUp3ZDNJd25XTzZMRkVM?=
 =?utf-8?B?OTArMUZJaXhUTi9kNk5Yd2tGS29HZHhCd1VEZTk0akUvdTVNOXBnaHBzcjVO?=
 =?utf-8?B?TDRKUHY4Q1FxSzJvTEJrTzdzaytvdEQ4MEZjUUh1WkxJcHI3b3dZSkJaTVlU?=
 =?utf-8?B?cXVkejQyTDdZWlpRZ3VJTXBEOVJRUjNEN0twWkprcXM5QURMTTlGRWs3NFFx?=
 =?utf-8?B?K0RYNFNMeGFOSzdNdzMrQzRsTXVHMXVVOTRnMTJGVllyMHZQem82RVBiNmxk?=
 =?utf-8?B?VFRHK2QzWmxNcTBPSnEycG5LVmZFK1A4U0xvK0dDcEFJV3ozSjNMTVZ6c2k5?=
 =?utf-8?B?OGNpZVlCNGJDNytEby9zSGEyL2lYUGo0UUJXNG80Rmdtd2gyaDM3dXJwUm5R?=
 =?utf-8?B?SmZvSGdBaFVxSkpOVEhOVU1UU1pMVnZUaXV4L1Q2WUZ0SDNKU0NTcE0wZVho?=
 =?utf-8?B?cnY4b0FYWFdMS1RIRnlrOE9QVXhOQ2h2VExKdm9OTW1hT1hqc3E2QlM2OHEz?=
 =?utf-8?B?OGh5T0l2RFlpTDBPUGoxc2ZpVWNKalY2UWhpdFpvLzFkNnY1K2JzYzVQMzBY?=
 =?utf-8?B?TmhQdDNnb0RRbHNvYWovL0ordUEwTSttaGw1T0UwQW85MVQwSktoalVxK25t?=
 =?utf-8?B?R2l0VlZEN3J1eGtabDBCcVBjaEE4VnhZekJrZTZ2blgvaGlIaGRwRzk0Qjdm?=
 =?utf-8?B?NHk4bjJRdURZUjFJVmNkQmJkVDgrcHUwbVBoU2pEdlZ3V0dwTGFmYURyT1p1?=
 =?utf-8?B?S3ZZVWpXZ29OUmVBaE9OMWpJMGN3cTdPMGZYS25sUExGVm1GNWk5U0hWczg0?=
 =?utf-8?B?VllOMTZxa1VqMGVPbEp5UVNOS3h6cUxHODd0OFE3dFM5YzJoMEdLSmltcGtG?=
 =?utf-8?B?VE1vNG9MWEhrcG5xKzB0bzRUT0NDUlU4dVEwaUVUenlsSkhmeUlDMEdqUmhY?=
 =?utf-8?B?NXZRTk1yL0U2ejFhOFFkbmduN09GVHJ3RUM3UHhXL2pSZitrN2dvMXgvSmRa?=
 =?utf-8?B?UG1YU1NBM2lCM1kyclVqeUI4RERmM2owZXd0NndxSUFHWVpMdUUrYnNQUE5l?=
 =?utf-8?B?U0kydHN0MEZLVVpiYm1uOEg4YVRQRTNXdXNGUzlKZTk3YUt5UmZQY1Zma0ox?=
 =?utf-8?B?YzJCVis4RzZHdGpqRTcxWjZVSVNpaE5wbHRsclFHaWUxdnUzZkMycThDeitU?=
 =?utf-8?B?RXNNd2FjSVdMRU5kUXhqZkVOVHZYd2RlUjNWREVqS1ZjOFkxT1p5VElxMnVO?=
 =?utf-8?B?eUVPWFNZK1VvYk9lUk5aZ2JIS29ydGtTL1dUZGl1WllycU9JaXBVZU82c21I?=
 =?utf-8?B?QWJDaGJ3VE4zK3JCdjNuendSWDdWUmsza1Jud09OeTJnK2lsTytqV2pnQzc2?=
 =?utf-8?B?cnFVZWtzeng0ZERJV05KRkdzRkVXVlhxOUY5VFNJTU53cmgzMytGRDRldDFS?=
 =?utf-8?B?WmJjdyt3T0FkZmlSYjFBZ1FmcHBzRWRPdVRzZTBaZ3Z6T1I2QU5udW5keFdX?=
 =?utf-8?B?dml0T3JzSDlTWjZmak9TbU1Uc3p3UjRJSisvOTNCVXFEbDNFV1I1OWkxcStF?=
 =?utf-8?B?RUVwT0FPMkpQKzlHY3dqY3FCQVg3RE0vU3NBVlVYckxGRzlLd1NhNDFQc2Fq?=
 =?utf-8?B?Rk5saFZXOU1vaWJON1ZRL2FtKzlaMVBZTEhTblprQStqOW53Z29ncm9oV1Fr?=
 =?utf-8?B?UnNpU05QNzNWeWpjemplL1A4MlVBQnhuaGNCemZVR2wwZW1tMmpEY1R5VEFM?=
 =?utf-8?B?d29INjA1V2V0Y0hOTDRqTUZXMlNzUFJoUUJ3d29FOWp2enpHaHQyZ2IxMVB5?=
 =?utf-8?B?R01BQ1Z2MFhYZjdOZVFlWmM2dTh3RXhGNmtvSHhVQ1B4eWZoajQ0V2Fpdk1V?=
 =?utf-8?B?V2pBZk0xNS9UOGNmQXNyZFoxUURnK3o2Q0FBKzJVKzZrS1RMQllwaHNWUFhw?=
 =?utf-8?Q?hW3esTXlGYPJxdGISZGoP8R7R+mlKRaSgBx+KIQd60cv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db0584e-2bb4-4a2d-f45b-08daddb40701
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 09:17:33.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42rjueLy750OxU4wzzyJQl4hwhM3P+O4GxMQu9XCP5c640uwwnNrYchSxmOWIQkI7DoQNKfH/yWR5sNQhG5IWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.22 09:14, Puma Hsu wrote:
> In mobile, a co-processor can be used for USB audio. When the co-processor
> is working for USB audio, the co-processor is the user/owner of the USB
> driver, and the ACPU is able to sleep in such condition to improve power
> consumption. In order to support this, we need to create hooks in suspend
> and resume functions. We also upload our implementations for reviewing.

Ok, before this gets hopelessly unproductive, please describe what
you are aiming at and operating on in greater detail.

It looks to me like you have an audio device that is connected
to the host by USB _and_ another bus. Is that correct?
Will you submit the "subdriver" that drives the device over
that secondary bus?
The operation over the secondary bus requires a hook in USB
power management. Why?

Secondly, the naming is atrocious.

Now could we please first define the technical nature of the issue,
so that we fully understand it before we debate the desirability?

	Regards
		Oliver

