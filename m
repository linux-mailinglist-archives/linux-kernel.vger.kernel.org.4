Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E165BFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjACMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjACMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:20:58 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A35C65F7;
        Tue,  3 Jan 2023 04:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUlZ90W4kvM3tWih+JZjs3CEEv5GvAOydKNoBfdQdpVKAdhaSnzmIOj22Yh11qIhdMGLaZURD0CnNoeuYoM9ASpbREu4aQIcJjesyeJvNtRk1ZllUfG12MTdCUO1viDvN3eFeopKKXES0VVWZWy1RSbAaev4ClhBKDKHN5Fh6RF9AmKbd74IurU1hzBH6bFW5lgZBJ623ipSSJyww/HBwovi0gylu0lsmjlcPttDGxHvw5QbhYk9N9fabo/PmN3441KMInzgzuBI+sYnZr7mSu59RbteGplMoMlKcY+pm462Fi2Pjobagw8QrUlKhRDH8uaoEGWtfnZyF6PqUsrgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMFi1AzfFXIZyJjC+JEKVYNldeMRCSVs5qyXJZfuLJ4=;
 b=XEdpSpayeh1X4YEMtCv9H2B4j54ohPF3FI6dWwj7YpDOtJEAMA+iKaKzoMOVFFq2H/4GpoLdGzxYIbnBhOANd3ZXH/RYasuaVjE9FD0V2I579LM83Z/l7WFFy7LZuoHw127WpAdZ3iKQnzL4CYKjOjnPaRGMeHC+3mTKEfmt5Nz9nX4cOY/rn5sz2HDcoicoUEWMtj5JmakCIRc93qTJbUYx8f9RGY4FMjHGVrk55dOs7iKIwaZk7NMiC9vWD8Esb0RLzEnrSCfXqLfWlI5qxezyR1+mP8EWvrRb/ya68EJ13mAci3NZRS/mkWRQbLE/JtcpiqK3wRoCNqTQ4SWwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMFi1AzfFXIZyJjC+JEKVYNldeMRCSVs5qyXJZfuLJ4=;
 b=npj1n8b+czrNW1cImVzid87kjJNIcsiBhAK5+vp+KoMy8GXPmXKBJDcVThtGKcS6HIhjEpx9Iu1geZbreQxhvpd4aBS38AEgbeNSXPlOEI7o1Z5vECgBA+V4W54mwjHY5G6+crIZE7HQ6BLX9vOxUTw8WLhXLm+hgFDddX+/jwpQ23M0b5GtFNpF3HiqX71O0Mw0vjQwoXNjs8XLJe0ZFQwYtSIJjbHGv2ZEIpmeHuNcKvLZ5ZQClIOZigiLtMyxAbRzXB9Obsr3CYyFzgrhXdug3gRrI2WpQvtzsrzs2nGW1X/Sd9Le0oGEjNeNuDysdtp9rpbVFqGDvfM0ynj+Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 12:20:51 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 12:20:51 +0000
Message-ID: <465bb512-2ea3-ebfc-4b21-7b493f019fc3@suse.com>
Date:   Tue, 3 Jan 2023 13:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op
 callbacks
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-5-quic_wcheng@quicinc.com>
 <80f92635-6d14-8ff3-17ac-de2e5b977947@suse.com> <87lemqxpet.wl-tiwai@suse.de>
 <ec632e64-2d9c-3f71-4fe7-e1c6acb81393@quicinc.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ec632e64-2d9c-3f71-4fe7-e1c6acb81393@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 18498be1-603a-4602-b3bb-08daed84f3bb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu8V4gIxg8A8ymyw1Rrmqu8RGSCBCNIZey2b4K7r3PLAdXjZm+loIUAaWaF8bgp4rKyR5SFnw3iXGEq6m5thKAoxUnN0JLw9C3p5KDt1uEDGV2ShrqZQ04HNDjjkIaZAQuJlT/c/QqqR4JyZeUQKaCBlYhDKpcLhsAfJwsAKOcBnI0pfTC9qptsZlPd1EpTE45OcduowonQVQCFKQF/Ksb05PgkSzz7ncpf1FPIaCwg6FnRHaleNRYJxr6+pGU6wpzSD0H6atO/MpcrcB1O0AspxhR5M+s483Bo/0tSjxwghQOzFdXS7feB4t+9JNGwJQCxeViAkkRlOF5P6FsDiVMcoOtMRmytfGG075J89xhWjXlF6dqpSM6Uw5NAL/BFr9FX/2Nw+VXBYlAY+i8swQorHtyKQAdmXx1klN4HRXUwVS/JioJpXoSqnY5BzADPUKFRDnouVUlg47z0CnenKqvyP2rhO7HN0e23GuHJSizyXeqVWOWugoB0zaJZPDiDxcHpzu9PyuMWyHW/8fuqsqNZ+tk2asDBzpCPnIVRjVogL6VjtwO9+r4oOLWGBc22jQXyH5G8KjAS+WxRsDnPurQye/tyYAXWmaexvC/evl71g4cOgjFad5nLhAaTr0CpQExF75sQ0i9nDCuQn8dHzrQh+0yrCLbWSrBTqU+B/gM7klJMPUbYS/wtTZWZ9GZNfwJ0ny1U0c8fvXD9GfBkd1yAfDH5IAMFh1pc6V4nmS20C+7TLZdz9QCT4PCdVwSzE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(7416002)(31686004)(5660300002)(2906002)(4744005)(8936002)(41300700001)(4326008)(8676002)(66476007)(316002)(66946007)(110136005)(6486002)(478600001)(66556008)(2616005)(186003)(6512007)(6506007)(6666004)(83380400001)(53546011)(38100700002)(86362001)(31696002)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtLN1RSTlY0Sk4rdXVuZjNsSW5lT0F4VjV5dS9VOXRPQnltbHdnN05iaW4r?=
 =?utf-8?B?Z0hmRnVuN250STJnWTFiMzRvZDNoZDZQcFRhTzlBZ2F5TDlaQ1VCanllU3pB?=
 =?utf-8?B?RHVtZHJ2RUtGdzI4TFdFcldIT1dmMFAraDI5Z0F6Z25vaCtLMUJWVWxhbXBB?=
 =?utf-8?B?Nk9BaTl5MHI5azBmNmdka2M1REx6ZE5pRUJzRGVHdC83Y04zZlRrM3JNaEJ5?=
 =?utf-8?B?OU0rVHYvNlpKUXJEK0QvdnM1UnY3L2U2UUxQZS93WDdxWWJWVS92TUQrYklG?=
 =?utf-8?B?eVB5Y0pDVEtBZWtzdDBaK1UwQURkdy8zWlg5ZVVIemdnVVFxMVFBV2s2ZUx2?=
 =?utf-8?B?UytMN1RjZmpicFlSOTFxQ1ZnQlFMbndoUHdKNXM1dzZndkVxQTA1OWNwWFcz?=
 =?utf-8?B?ZnhNK2h3SkM4WnM4YVppaFhwaWR3YUdsNVFqYkhyTUVjTHBYWUUrY0orNmIx?=
 =?utf-8?B?dWRZMC9VTjI2bndjRkJXZ0VGYllZNmUwU3NQUko0UlhrNG81QmRGbEtaM0Ru?=
 =?utf-8?B?NGJtSGRnRUh1YStDTXEyV29RM3d0SStoTFZrTHlYMUlPWDF3K1BBYVZQbis5?=
 =?utf-8?B?TjNzUFJOcGtlSHVncW1KQlM0bTFKODQ5bW5mU09SKzJUTzU0cjdvdU82SXdX?=
 =?utf-8?B?c0NXeDd5Zyt3QWFSZFZ0R0lJL2M4dk9HbWFEL1dhZVhpQzRNa2RRa2x0UVN0?=
 =?utf-8?B?UnJQU0MvcjNKMEJzdjRSK21KaW9TZEtDd01aS0o2emUrYTBKUERqblYwV2xv?=
 =?utf-8?B?Ty9mMSt4enRJUlBiQVkwSDE3NU16T1NPRG1BK3NwWWJIbnhhQUs2UkZIajZZ?=
 =?utf-8?B?dmNDNVNpNWtSU0hNNG5TbkVvZmM5MGdLdU45cG9XZG1qRmdoWFErNThWQVR0?=
 =?utf-8?B?UVV2b3ZJdnM1VmRWZWI3VHJLcko0ZHNGRnhiY1h2T3hEOEdxeHdXN2QzWko2?=
 =?utf-8?B?ZHFPL0JoWGFPbUdwRHBTYUJ5czJpQTI4ek1KVk1VTXlpTU5xVUplUGhyUWVV?=
 =?utf-8?B?SUVZVWtjUnVQR0s3a2E2UWJKRGhkUWZObUVIekFGYWlidEJkRkFtYzNIVExs?=
 =?utf-8?B?dzVSbmlIL0d2bUhpV04wOFBSdjNuMDhtb1hLSVlVZFVWd3gvTTVldTkxR1d1?=
 =?utf-8?B?ZDVMYW5MbzhNWGkyTVA5MXFZWEY0SnRzYktUSWdObEtyRUQyRFlNQnJHUzZN?=
 =?utf-8?B?aFBrZmtZOWZsaEU2NUtnMXRwRUR2cm1leThibm5IUSs4M0h5cTdTT2N5Qndw?=
 =?utf-8?B?cFpuK3dheU9EOUoyc1lka0xaSGpwR1hIZFFLYUhzVE1kRUM4eEU3dHozQzQr?=
 =?utf-8?B?UkFMRzhIZGR4cUZYOEhnd09EUXEyNUVRK1Q3c2NlU2N5bDhhcGE2NTBxSGcy?=
 =?utf-8?B?UU9HcWI0Zzltc1N6aS9ReitxajExMzlQc2RuTy9pVkp1SmFPNVRmZ2NzRmhq?=
 =?utf-8?B?eWJ6RnB3Z2w3eUR2dW5xV2RzNFlUR3F6NWdhS3BBTGpTRW45R1h4K21heG0x?=
 =?utf-8?B?NzgxUjFVb2NXbUppYjVqVmZudUVxOCtMbHl0YjA1T0FRaUVlSEVVR3gvdTNq?=
 =?utf-8?B?alhQa1VkLzFKZ0RUdW04eWxFM0tBUkFGUWhHL1FtZzJzMGx2UGJiL2srNVRu?=
 =?utf-8?B?TWRoQnREN3NFeXdZWWhQbldvQjNsWWRvN21EalZEdGZjemtxcVNpRW5nbkMr?=
 =?utf-8?B?QS9ucWJXdGF6aUFjdUE2dVZVYUJVMWl4SXByd1l4ejYvNDNQOG0zUXJtcUsr?=
 =?utf-8?B?TTgvUFo3a2xDWG5tQjNJQnBWY1NYQWtQaVBNVnBjSFhGOVpLQlNycXNwS0tj?=
 =?utf-8?B?YUxLTmdOY2ZRdjlyNXNmVlVTNnM3Q01YVmdkWXdPRERzd1B1Zlc4VW5lWWww?=
 =?utf-8?B?UUFPNnlnUU1qWXNTa3ZLRlc1SjZ2ZForMGM2QndhajFOcE50S3V5ZFRUMW9r?=
 =?utf-8?B?c0diMnFvd0dnSVRrdWNtYzVuNXRjTml5V3BsaEhjb3R5OFgzcW15WmxtYmRW?=
 =?utf-8?B?NE45WktQalJtS25MNXdLNjlUQ2R1V3M5dWFpZzZ6aGYybWdOYjNuTjFrMlNS?=
 =?utf-8?B?M2J0eFViSHV6YTdUNkxVRDRUVHpWbGdOTUtqbGk0TytXRnZvVlA4OUtnZldT?=
 =?utf-8?B?L1hrMVdmd2pzaHlsOUNuNnppUzFJZ09OTWo1VzdPSFhSUktYU0VraGhscHlI?=
 =?utf-8?Q?1uI4aEV2ELPjxeEhL1KtvUbo4MSg1ZfSMjkSRhp/EsUQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18498be1-603a-4602-b3bb-08daed84f3bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 12:20:50.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +olddsnOmrrb9vCuUrIphZtUSWiEsnobyju6NKwy8GukUWUpu8suj4BEQjiBe0PG2r5XFffFqPLc8xvGn1ATqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.22 08:10, Wesley Cheng wrote:

> It may depend on how the offloading is implemented, but we do have a mechanism to force the audio stream off from the qc_usb_audio_offload. Regardless of if the UDEV is suspended first, or the USB backend, as long as we ensure that the offloading is disabled before entering suspend, I think that should be sufficient.

You would presumably output garbage, if the UDEV is asleep but the backend is not.

  
> The reset_resume() path is fine.  Bus reset is going to cause a disconnect() callback in the offload driver, in which we already have the proper handling for ensuring the offload path is halted, and we reject any incoming stream start requests.

How? If we go the reset_resume() code path, we find that usb-audio does not make
a difference between regular resume() and reset_resume()

	Regards
		Oliver
