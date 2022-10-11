Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878D85FB25B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJKMXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:23:23 -0400
X-Greylist: delayed 294 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 05:23:18 PDT
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1508E0F4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:23:18 -0700 (PDT)
Received: from 104.47.1.53_.trendmicro.com (unknown [172.21.205.29])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D70A410005109;
        Tue, 11 Oct 2022 12:23:16 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1665490996.283000
X-TM-MAIL-UUID: b6dcbdac-1cec-4966-a1da-7934057672b0
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown [104.47.1.53])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 455CE10000303;
        Tue, 11 Oct 2022 12:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egzqnSmiuR8CqdGfek1UGd8BVRWqaSMIiSqjTn2lEF7PvlZQai6q/oyLButAMCg0ZbyxTtaVfxPciuZE+Z0gtrAtJ7OHYuqJrJqBtz9YwvgqhkxvJxvwxEsP/78ou8E+uulQeazCysxJA6dH1xlk/pDFi9a342PTtulih8vvu3N/ISwsdaGFXFf7SCho9XPweyOOrEkVOf6qY3Ars9ig5u4MzEQpRfEcq1Tbm9q/9mG+ivG/cuNuEacxmxBoFI0cXiF+d9xMqm2hMLzjUG1QStctpLmPp6rckKl7p6R6ni1RVoLrnyGd0vlQI2C8qw3qB5rup/V6ueg9B+sBznrvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmEkS5tWimUD0l99+Bkzt2GwkXIwNZZ4DdlveDTGutk=;
 b=hq5cRNK7yhGaar82//iV8em2ZQAB9JS81PVjxHaUOYLGIZKVQjvZ6jV0mSAESwFAoFCX5Tr2M4hbsN01kuUo+lsr9McA0a2OZd/MqESFeZEXDbIAZulYktDzbOaZMtHoYtv7G2SwlIXd9tZcdsAxkyE6qr34xwbxS2J+3eXf9bZNPtYDk5g9i8Wy3QKpKodfD52zBc9j3ftJc/8nvDgi1D8T31tFxKZEFUF6ViW8xhZ53CDA0DW5xKiaOtV7C7rQF/uLO9VPeRH0Qj5XGuTlq/C9ysHhHm7TGasEvogYFU4VgWQNlSaDL8sq4iZXsGF/Vv7REpMmxvNU6dtsbX3rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d41ec1d3-e262-3be6-17f2-a9495c55b868@opensynergy.com>
Date:   Tue, 11 Oct 2022 14:23:13 +0200
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20221007090223-mutt-send-email-mst@kernel.org>
 <CABBYNZKfLOxrTAVLRSH+hOwaB5RYkGdjbtfabufUcgR3oy897A@mail.gmail.com>
From:   Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <CABBYNZKfLOxrTAVLRSH+hOwaB5RYkGdjbtfabufUcgR3oy897A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR05CA0029.eurprd05.prod.outlook.com (2603:10a6:205::42)
 To AM0PR04MB6641.eurprd04.prod.outlook.com (2603:10a6:208:177::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6641:EE_|DB9PR04MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ff86e8-91cb-472a-2396-08daab835ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iHNn9F5PLDiss8Y7PZCgdgjTMK7muStZy39wayivyzDZfAfgnXUwyV3R/JNm1iMwpgoP0Qv8yiRhWQh613xDjlNcdHCD5L+ZGq4iMRaXtGZl/+YE0dEpIxg4eQMMZrnY0q0QMqfuzOvkmTUsKzI5apzsXCFAA69uCptXYjyMQ69+ZUv58l9n4xDgHrIAiZ7L2KlDLaYcURE5mY4NMdD9qZYNv69KxSyJsIDa0MKjRrVq/B4p2HWmn19jJ5BPQIRLbAtJBHyJnbkB31AbDb4cGrtSxymd8GBS6V1XC50IuC4zN4x4xgpIXyN48HrizZdAXHR67YxntdmG6lSERyolu7cO/QASu4Y1ZBlAxAAZeAwHA6Jx0enrZ3c0Jld5odn3bE0j/vT/QfG9IP9hy7bj2q6X3GJSELZsi5jGqZz0WsrndchQ8p7yfIk0U/Cn0TqT8OobUSO/viXSoWKc/nEzLOlkEuFZo8abESOK6oi/1LR6px+u4l/ZaxsIuo0QGlbyqvpNtJB63t8sI0rtowXcjjsuAEID5dJil0OObpKlwExbdMryraNuPTAhFB6ZDMC8K1UZErB4cfUJDXx9zvNO8svgkPDd4uXaYgHgaEgkemiPu7pgeXS60uyeJ/9qIH4ZBGkUxgWwG6L+GkMjaq9qfldYP17Cw5n5MyM2vyeW5Zav+RxM3covIIrTRe1uHBddVUYUrzftBR8HNQhlC9mJhV3WCXiOp0KIyMYouf9lF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6641.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39840400004)(396003)(366004)(346002)(451199015)(83380400001)(66899015)(186003)(31686004)(2616005)(26005)(66476007)(15974865002)(86362001)(31696002)(4326008)(5660300002)(2906002)(53546011)(66946007)(66556008)(107886003)(316002)(966005)(38100700002)(478600001)(8676002)(42186006)(44832011)(54906003)(110136005)(8936002)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU4zSVV0bVc1QlNYcVBrc3JoWFpuc1ZpOHAxY2VLdUhyajhkVDVZY3M0elU4?=
 =?utf-8?B?cWVIZDRhWnVKWG1sd25iSnJhQzVYMlBwMkRxQ0ZkWjhYazlkczhDRXNmRTRu?=
 =?utf-8?B?MXZXSTZ0bVpaZkxVOXQvMjl3ZGh1TlJzNmoxeXpmd3ZQYTdHY2RjbU03L0l0?=
 =?utf-8?B?dENLaHBIY2J3Y2xjWWZqTUVWMUZiN3Fndi9WOWdZb3N5ZmxZaitXMDcxSkJG?=
 =?utf-8?B?Uk10aVpJbHp3bkQ3bXFqL29CbkhGOGowZU9uTWpuNTZvOGdFbExJZVhOTFVF?=
 =?utf-8?B?N0lhSkczT3lsRmNqYjNpRGthKzQ5VjBxOGZhdTEwRTYrc1JnZmtBYnpTRE5L?=
 =?utf-8?B?UENJdHRtYThxQ0lOQWl2MWZ5V0hSaG1rWVVjNkRVUjhrMGlkSmRiVGhodFVa?=
 =?utf-8?B?b3AxbWowaHBEZEsxOWdPbFltM0F3YU1vNUxzN1RESXNaV3M5L2hvWG8zNjFl?=
 =?utf-8?B?WTAwbHJ4K2N1ZHhlNVVOMWpVbTFVbERTT2NWRWV5OXBuQUlNNWlob1BOeXFZ?=
 =?utf-8?B?cFNManBES0hJV2RxQzJabzlOTEkyS3hTV2l6aVN6YWp5cHhuamg3UjdEYWdY?=
 =?utf-8?B?N1N3V09uQmU3SlFRQ3FPaEhMY3VKa3A4dnFqV0lDeWgzWHZOWWZnMm53Q3Jp?=
 =?utf-8?B?akdDSVFpRUoydEtta1JrZzFsd25zQjhnUm1VSjUyTm9wSVJIS0VnejlycWNR?=
 =?utf-8?B?ZU9SMU9BRUxkYkJ4cGtnRVhhTFJ5TFZSdlRwQjVsbG13SHlqOEVoMXE1NlNK?=
 =?utf-8?B?eGlhazFwaU1Yazg1UkI2ZkE5UTloNUYwZDZ6ZVF2YWVuWDJUK3F6UTQ4MTZ0?=
 =?utf-8?B?bElocVB4ekVucWsrbW5yZzRQMVJ2Z3ducmdrY1N4UVBKMHorMGgrM1QrN2Yy?=
 =?utf-8?B?cUhrZG1tL2NmS1FVV2oxODY4N2pSUXp5cWpDWnlIL3RJS2JWblJrQXVoRTVz?=
 =?utf-8?B?Nk9CSDh0TDJoZzFyU2F2cHN1Y0hIdUk4TXBoRkZOZGhqWk14ZjhnbUVFR290?=
 =?utf-8?B?NnhZWDFlcjdFK1c5RHpYWSs5dmhGYkdsUGF5eGJmNzBkbVhhcDRtUUtPTGVO?=
 =?utf-8?B?WTd5aU54MUhVTlo4emhDZmpncGpIdGhMRklkN01mTTNKdEdmcERMWUZpT09z?=
 =?utf-8?B?YnROTVpVbWdIWG1uUWIwSm41b1hPcXBVWHJuMVpTQVljUncvelN0OTFWOXAv?=
 =?utf-8?B?UTAwMGUwUU5pSGFjQ24ySU9mbllMTkM2bmJzUzBGQXVHZkpkYlRESitQZ2NB?=
 =?utf-8?B?MVc5ZXpvTDQzY0VzZmxmVnNUaCtTc1JjNUZhaG5GK21YS0hoREdWMDI0eVdT?=
 =?utf-8?B?bUlqV244S3MweTc3L3VVU3pucCtUTmhHYnBvRXc2L2FaUTNDcGFTR255T1Ft?=
 =?utf-8?B?OEUzWmlRM2UrUDN2YXJNMGkxQ1cyZ1kxRFBBRjkzTzlSTlg4OVNXREZrWXVz?=
 =?utf-8?B?ZlZ1bEhxbGhkdkdrSGZOZEoza0dyTGkxcnpOcjlCcmFBaGVRNGJHNnRBR09X?=
 =?utf-8?B?QW9yaDBvU213cTVqOS9hOTBaQlR1OFg0aEhpZ3ZOazR5NzNqeUZrRHRWakNl?=
 =?utf-8?B?SU82UlV6T3pZRGl2K0o5RlphODhXSGVIbUpBVThYOUVWV2RBejNJcEVEOFdU?=
 =?utf-8?B?c1lHTWIrMkg1ZklRcjZrQ2JlR0EzZ0szSUVwdmhqS0NLTUdWWXlBKzRERVAx?=
 =?utf-8?B?RG1jYURvdFBmQjcxdVhJKzlxQSs1RzJVMjY1Y1F4RGVZKy9la1F2SUtLSlZT?=
 =?utf-8?B?Ry9jbWFKOVJUdm82QkxtQWpmdnFFNm5Odmk2U2xzbEo4RVFQVURWWGtmMitu?=
 =?utf-8?B?ZHlTZE5BNVpEK3V6TCttSUdwbDlkckg5RUJvdnBqTUE2akdVbUFXTWg2dUxJ?=
 =?utf-8?B?V0JWdDVWVmtBc2pqZFpVUVcyZVFZUldQVWZKNHdkTFN0SXd4blUvZDEvOVJ5?=
 =?utf-8?B?SWt6VDZhYzF3V25iMURBQzl4aVhQN2tENzUweVg1YVBOU1ZhNU9PR3BmeURl?=
 =?utf-8?B?V05vMHgrd3MwU3g2eG5LZWJWUnhDMFlRaG03ZzZnK3cvYnBoMWlNM00rM0F0?=
 =?utf-8?B?WHRiM1NxeEhaWDdsaWFRd1lyNzdEVzRnMUNDSHBjUFBkWHFFYmRUaHNHNHp1?=
 =?utf-8?Q?bMkPzIcfiAX4BmeBQFo2G6/YJ?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ff86e8-91cb-472a-2396-08daab835ea4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6641.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:23:14.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA3HwlJLDANLq7+1QD6s+5OfcYod6wZnWa7xUFF8I2BxPH4hg1e7c7w1vCeYiAKZe9OyHWOLc+1FnuHLO+Z80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8074
X-TM-AS-ERS: 104.47.1.53-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27194.007
X-TMASE-Result: 10--28.559200-4.000000
X-TMASE-MatchedRID: u6ojmU07PKx5iFRzqt4l+HzmmMD/HXF+1QQ6Jx/fflYRt1EvyOXA0QVF
        2e+BOedtCvLWyGtWgLMcU+PyDJ+qWg7Qbfq/wswqCbJWswK4n1JMVCcj56k8hh0zI+Wuf+4madD
        T2vy0FY4CZ6bzAWtZ31WN0ScpnS9WXSJ4c3nT+QemSbHM5MJ8EEhMRy+qNwXguWX5cj4acazIFG
        fpXhVj7rZizyV9KTDSX8vdD0rtBSLTDG1YCSkAiRHJWwDGGGOshj6De48DqJ9QKAQSutQYXF3C4
        gO+usfrxpVEufocXAPWcSFj7AkGKlSaKReCNW2DAxFf86Rcir2HqfCKxjr5zd7p0Ru8jKvFtb2J
        h9lM5XAWm/gAtjCd7LTSJrCbxY6LU6K87V98CkR9SSAOK4bGfwmWvXEqQTm5xuXV3UE49jhfxNj
        hQhyghW8X2hD8HnjIwNbXoJHIkLCrofp7IohGw07nLUqYrlslFIuBIWrdOeM3ZbGC9oP/O865Qe
        rn2w9CCjtHjO8gdgkiAhHixcJfg1rfFqtYHPzbbFnnYKyTEP7YC1BTtzVr95yQ66GXvSlDMoX05
        tRqtEg6yASP47PB3oKz04ni00BOqJIiwhbq5S/dCok3ibXlQUVRResf5NVp6wF9rre124PRt5TL
        URRxyefOVcxjDhcwgaw1fl6D9o5GONWF/6P/CqWjE0K8Zqo9KrauXd3MZDXwMUUgHNDhDSLiYnj
        Vb876ftwZ3X11IV0=
X-TMASE-XGENCLOUD: 5f1a4083-99f6-496f-b657-2821e3671b2f-0-0-200-0
X-TM-Deliver-Signature: C6B6CCA9EBB7C42846A7520EDF945A48
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1665490996;
        bh=LuEloUG5XJDbOcUQR+s3+a1KPD97nUMIyDDzvtNKY54=; l=4942;
        h=Date:To:From;
        b=zeV41sHSL7jfTl+cKdIOFfXvGXPPUQKBYy3dP5un61f/1tu5Rgse4G5E0PD2a6JKB
         1B4ORo3GDbEJMuDbCAjpvDqXMEg+t5WTJsrN+R+155eG0nKI4aH63PUJ8xZuWzMwZb
         IjGsLtHLq8Ql3QESEHUZ1iWRrfcY0HgM5s6TwPonOJYhjUkTy15012glfy2h+MoenQ
         QkhUjE8xkJMzR3HlnjrT3Rc+uWw6U50djxZB/xZ0NZaMNHgiW3RITjrVAi7+bJwzyL
         6rPM2KIh3AZcj7b1UrQ4G0w4oLFKNIzfjYexTZFOG9yuYh9kydr93IErEsA5d6NAME
         ypvBE3b8RFgXA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

Current version of this patch is wrong [q]changing uapi like this can't
be done, will break userspace[/q], next version is in process, will be
sent in few days.
Best regards,
Igor
On 10/7/22 21:33, Luiz Augusto von Dentz wrote:
> Hi Michael,
>
> On Fri, Oct 7, 2022 at 6:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
>>> On 8/8/22 01:00, Michael S. Tsirkin wrote:
>>>
>>>      On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
>>>
>>>          According to specification [1], "For the device-specific confi=
guration
>>>          space, the driver MUST use 8 bit wide accesses for 8 bit wide =
fields,
>>>          16 bit wide and aligned accesses for 16 bit wide fields and 32=
 bit wide
>>>          and aligned accesses for 32 and 64 bit wide fields.".
>>>
>>>          Current version of the configuration structure:
>>>
>>>              struct virtio_bt_config {
>>>                  __u8  type;
>>>                  __u16 vendor;
>>>                  __u16 msft_opcode;
>>>              } __attribute__((packed));
>>>
>>>          has both 16bit fields non-aligned.
>>>
>>>          This commit fixes it.
>>>
>>>          [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1=
/query?url=3Dhttps%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2=
fvirtio%2dv1.1.pdf&umid=3Db1110db2-819d-4f27-b35e-18ac23ce0ab4&auth=3D53c7c=
7de28b92dfd96e93d9dd61a23e634d2fbec-2c53002097633a932e7d67b899e6bf6999cdc89=
9
>>>
>>>          Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>>>
>>>      This is all true enough, but the problem is
>>>      1. changing uapi like this can't be done, will break userspace
>>>      2. the driver has more issues and no one seems to want to
>>>         maintain it.
>>>      I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
>>>      to merge it for this release.
>>>
>>> This is very sad. We already use this driver in our projects.
>>
>> Ping. If we still have no maintainer I'm marking it broken, users
>> should at least be warned.
>
> Please resend.
>
>>
>>> Our virtio bluetooth device has two backends - HCI_USER socket backend =
for one
>>> platform and uart backend for the other, and works well (after applying=
 your
>>> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "devi=
ce
>>> removal" problem can probably be considered solved .
>>> We could help with the rest of the problems you listed that can be solv=
ed
>>> (specification, QEMU support).
>>> And the only problem that is difficult to solve (because of the need to=
 change
>>> UAPI header files) is just this one with unaligned configuration fields=
.
>>> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_H=
CI
>>> (Indicates vendor command support) feature negotiated, the driver does =
not
>>> read the non-aligned configuration fields.
>>>
>>> So, what would you advise us to do? Continuing to use the "marked broke=
n"
>>> driver, start writing a specification for a new from scratch, better on=
e?
>>> Or is there any way to bring this one back to life?
>>>
>>>
>>>
>>>          ---
>>>           include/uapi/linux/virtio_bt.h | 2 +-
>>>           1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>          diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/lin=
ux/virtio_bt.h
>>>          index a7bd48daa9a9..adc03709cc4f 100644
>>>          --- a/include/uapi/linux/virtio_bt.h
>>>          +++ b/include/uapi/linux/virtio_bt.h
>>>          @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>>>           };
>>>
>>>           struct virtio_bt_config {
>>>          -       __u8  type;
>>>                  __u16 vendor;
>>>                  __u16 msft_opcode;
>>>          +       __u8  type;
>>>           } __attribute__((packed));
>>>
>>>           #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>>>          --
>>>          2.34.1
>>>
>>> --
>>>
>>> Best regards,
>>>
>>> Igor Skalkin
>>> Software Engineer
>>>
>>> OpenSynergy GmbH
>>> Rotherstr. 20, 10245 Berlin
>>>
>>> igor.skalkin@opensynergy.com
>>> www.opensynergy.com
>>>
>>> registered: Amtsgericht Charlottenburg, HRB 108616B
>>> General Management: Rolf Morich, Stefaan Sonck Thiebaut
>>>
>>>
>>> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinw=
eise zum
>>> Datenschutz gem. Art. 13 DSGVO finden Sie hier.
>>
>
>

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
