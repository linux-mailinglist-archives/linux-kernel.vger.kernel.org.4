Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CCD60D55D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiJYURW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiJYURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:17:17 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A75D25B3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:17:14 -0700 (PDT)
Received: from 104.47.18.110_.trendmicro.com (unknown [172.21.183.236])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 532DC1000045B;
        Tue, 25 Oct 2022 20:17:12 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666729031.903000
X-TM-MAIL-UUID: 1dfe0b24-d994-4181-b532-379ac5202046
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.110])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id DCBFA10002512;
        Tue, 25 Oct 2022 20:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev2ptuh7u0c6U8JrksxTzIWO6GlaRAeISuPdr8NyDOd/GM/O0XPM2IuOevNDfYz3tWh7T5zSpZjY8VbN9idKuav6lMUKKPqgX2ZZqTPV3DlA0NATKpKj0uDQ6YhizHjxrv9+QWGeWFQlSbdq+zg51oDJdi/BmUBFPRRq9nwz3g9O5g+V/p22V0E0p45iZ6Zg71uYaaxneD76K2vfrkPU/o6a/fV6SEYtCkUgZlri01E0wcdn9EaqWcPs/JjNLULuovA9y63txsu0ocj9AgFalRnuila+N90ynxJ9ZT0KG7kp8TalDA7JkHuERiYYAGRC8PmMQT2D4Y2qQihhvgw/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOjT/m3KaiDExxchJhnwCUpr+UXF3YX8ZuGxRObWEyY=;
 b=UGUeyvw0/89CibxM2/6ZUDSZCJMMh8o6/OnhYB1le/Zolt6ra3EmWqmWovDV0vY2irj0fm8Ve/FdPy47//Hip85rJfRDzrbOfKEm0mUVjkuH9ABwaj85MmdVpJ3g/j7pRJ6bFDLXT5VMZLZeaqiiybat6+fqpFTsuF66GlgWc7+rdidhJwn+crCMJJsdfc9cZlewgCIJCLBd8QEd1wD4U4FoRkPuTRFwjGvTSGSE1xJcHZeV4XpOgW1ezGC8M0H05UGqoXA9IDAVfalkH/TqxknczX6sDKYCNTll1815YsKkRbckSE6at8OPHbndukE8ilEbRVfQ5k9lG3cV98fUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a0ea56ee-8cf4-c1ef-de15-1bbdb0340da6@opensynergy.com>
Date:   Tue, 25 Oct 2022 22:17:09 +0200
Subject: Re: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     virtualization@lists.linux-foundation.org, mst@redhat.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
 <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com>
From:   Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To AM0PR04MB6641.eurprd04.prod.outlook.com
 (2603:10a6:208:177::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6641:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: cae922c3-2d31-415c-4ba9-08dab6c5e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlcwPqEDrbfgBneo1UFWeolhfRoEyeFiL07KitM95T51f7ie+MlujzKNHPM6MPeMosPTGztP6l4zvVbIlKFLv0qtA7u5Cyx5fCRVL7O/zJ0SYaV6J0VXZ7p9EpLSsgH4hwTPtn4K6vSUa0fUHumaAgqxkaZnuNDj/0ZmTFM3FIN0mDvEPXrQkonMFbkXbP8bW3RnNhndOlhjwqRXg/NOI516KXMWcX7XyRX6cfUZMLcJqa7sJbdNnW9uzhyP7ZEjLUn3GaAVvIleEJO16YLlhbDpOYOqT+6VjsfSIaa7Z1JBNHChQ7FOJjzf/0yEZuOUhEV2mwX8Iw3O3JkmfdlRu9uPruYRTLES3a6qLy9jbH1SaWWDc19m9V0T2lF7t7BbYV1sZhL9Uitd/q4wLEbW20CKHult8zbWFxehq8KlwIPkEZdd/gl1LltoXbpyf061juDQDhN3W2ILPU3kcRvYzWuVdkt202bfPOqi3qLgTxbE/NIi3AOtCc2p7KI5OZo1OZ6TBggSm/XIznWV2LLuvBHqRIMcURBZvmG4FhCoNcB6EILw3QHL+gWi5cRzII/iEyVTl7lWxY9KcyUU5unoro0SbnBsVsfn37xBvQACGb/22oIeGfTQN4Li8cNbxMxy3d2E10RoR3gumcjO8pSAFhjZEd/LrBA+Gwp7XjitH7O5E6KQEC1T1FYfWmNacUD8KF8Naxs4Q3OLO3sQ11BTBjGkMioNXLEpBhn47HpcWVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6641.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199015)(36756003)(31696002)(38100700002)(66946007)(86362001)(66556008)(66476007)(8676002)(4326008)(316002)(6916009)(42186006)(44832011)(2616005)(2906002)(41300700001)(5660300002)(8936002)(186003)(83380400001)(478600001)(966005)(53546011)(31686004)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFp4Rm5nY0VzN3lPMXVrR3FLUWZ1U054OVNaYVM5aUNTaldEendTVGdDSC9G?=
 =?utf-8?B?Y1N5NmkyOGRKVW9RdVQ4RzBCVDkvWHd2QzdUTkhMcCtpTnlnTEZtbFlxWVVE?=
 =?utf-8?B?SnlDYVpjQ0R5RDc1S3BQWFcvdkcxNjArdG04WUR3d0Y0T0tWSmh4dFBLaHVF?=
 =?utf-8?B?Um9LYXNlWHgxWVZESjBQY3hwU1RtU3pUdUU1MXo3QjhGOUNhRmtWQ281NUNt?=
 =?utf-8?B?Z0g4OU03cGQyNGtYTEE5QVMzZ0dkMStTenVHVXJyS2tqTko5V1FYelRZSmp3?=
 =?utf-8?B?ZThQdDEraklYM25yUWRiSUxUSnkwN3d1TkpRYlFObUVCU1BHV0FjSGJwZ3Ev?=
 =?utf-8?B?NTFDREdKakpBd2R0d1VEQ2p0WDZSOGtHc0NNNGhXVHVxZFU1UDU0MDFmaUxw?=
 =?utf-8?B?UUgrTWxyMFI0VXMxNUwzYksrWHhRSWR0a3ZjQm1XYmtOOUpoeHZFa2cybTd4?=
 =?utf-8?B?L0ZlLzJ6NWt4aFp6MEFhZ0hCWWduNlNuUGRCOXRSZmtUSHFSNWZkRFpYMTBO?=
 =?utf-8?B?M2VrcWVaMWUzdkRweVllc3FrNnJ0Z3lxZElaQTlvNmR3SE5DVUJkUjl2ZzlK?=
 =?utf-8?B?MkV5c1RZRGkzM1JSS21xZkQ4NnE3KzNVRHgwcGg2eE0xZmR6a3FVZzNsN01V?=
 =?utf-8?B?bWtPWFZ2VUMzeDVldGFLTGFwUy8zbHBpTktQL3cvM2x0VmtIY1V2ZitQa2Uy?=
 =?utf-8?B?a2Zja3krZWZuNi9nd3phdm5tbS9uS2xYTFNxU0YwOXNpQmx5Y1podlIwTGo2?=
 =?utf-8?B?NHczSDhxa1Rocnp5VGZxdzFXaHpadnpmbkpzcjFBc2I5MWU2WE5TWkJPazls?=
 =?utf-8?B?eU9GcTgzYmVmdFp4WWlReWdLYmYvaGV4MVlZZHdPUXlVbiswREx0OG9XR3FQ?=
 =?utf-8?B?NkUzTy9mREE5VFJmelROREhzcldTY2kwZGNSOHlNRUVmaUpoUDRNV1lhY3hV?=
 =?utf-8?B?dWQzTkdZUFlpL3Mxa2c4TWRIcTlrNFJxcHh5emkzejhyRzB1YnRoMEsvQVN4?=
 =?utf-8?B?SjA1dzJLQnVkQXRMTDdrcmVYUlYvd0FlVTRHQWxoRzBkSEVlVzd4NVpZYWZI?=
 =?utf-8?B?S0ZtS2tkYW1uYUQrbXlubjhuRm9OSVJSSFd4dHNIOEJuekZUWXpJRjE0cWVh?=
 =?utf-8?B?MEtZYm05TzZTTEpVbytvTjZxTk9vcEk1clg2NHNicnFxcVRrbmhHTGJJV2Rv?=
 =?utf-8?B?emNXc1g2N0s0YXc5TkpLb2NMUEN1UTVUekxWUzlHVlF5TUdrZ1J4eXN5Qk5k?=
 =?utf-8?B?NnRlQm5kVWhyc2JtTjB6a2hHV0sxVEpyWnREdFJ5QUQ5SkFPSUtCdTRGOTJG?=
 =?utf-8?B?ZkhSNXlMUVlLUk4rd0tiWi84Y0FpRHVpOHVTQ1c2cGV2T2tKTTQ1UkZhTU5W?=
 =?utf-8?B?ekZTaW9RY2Q0SFN6bVU3dG5oMTlybEUzdG9JblFLNU90ekJac2hxMnhwU05D?=
 =?utf-8?B?K2pKNFZhVmNtaUNtSmRUR2ZpOVMwUmJwc2I2VU1sUFBtdUhVL1BXclNqTGtT?=
 =?utf-8?B?dStIQVVRQUp0UU9meHZTYk5GZVU0cUc2TWhzd2lRVVNWSDVDWnU2ckxpeHJ1?=
 =?utf-8?B?QTNvbEtFT3ZkamJkTG1pNFZDYnp1THM0VkIrcUVoTmV4RDhaN2JhaGZNSy9N?=
 =?utf-8?B?WDE3UlpYZnFpT01VTDRtempOemRFYnhGOHlYcDBnUzlxdEIyeUgvbmxaRWps?=
 =?utf-8?B?TTdpOWdaT2c1QzFYS3piSzg3NlAwUURJMlZyU0ttQ0VBQUdmaWJuRUFteE5j?=
 =?utf-8?B?ZHdQVVF4cmMzSXpaZlVvKzMxUXk1V3V4RDNudWNJSk9uRHhHbmY0ZVd5ODda?=
 =?utf-8?B?NUV1ZGw2MGpCdVl3aE9SbW5jdTJhazY1VnB0Q2I0LzNqS0pnNlNYMmx3ZCtF?=
 =?utf-8?B?TXYvcGkzWmRQZUFKZDljbmNDZ2Y0dTZFdjVvcFc4OE9jR0tMSUwyMmF0aFlD?=
 =?utf-8?B?MUl5dmdWL0F5WC9sYjR1TWYxTXhSL0NyYXlpcEtTS21CRlR4MDBsV2dOSXB5?=
 =?utf-8?B?SGNBT2F0WjJmclgxS2JXNnhtVDJlbk9KTnpaUWJSczBabkhKUzIrUzlocSt0?=
 =?utf-8?B?bzBaaERSdmVQRk04ZFNwSkZUR2M4aXZIalZJOXJ2MHRMNHErSmRSWWo5N2Z1?=
 =?utf-8?B?d1dtcG1XT0Fad3E1K1BKK0lqZjF2ekRneXdxNmI5RnlRRTZvdlZJMkROdWR5?=
 =?utf-8?Q?ByJjx0cC2C1WIUg0YP4TkizZebsCHEbKKYklMKPRhZ0E?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae922c3-2d31-415c-4ba9-08dab6c5e593
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6641.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 20:17:10.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RueHDNMixUGG6IgtooBu1mf2teyYK/o3FwcW2azL6xWTSOZ/gw082qyQ80amk2niBa+Yg+SVEcbIJzEKgmRo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742
X-TM-AS-ERS: 104.47.18.110-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27224.002
X-TMASE-Result: 10--18.219500-4.000000
X-TMASE-MatchedRID: oHOSwQSJZWh5iFRzqt4l+C3U1yAFvRbw9mojSc/N3QdlEv6AItKWF/mv
        83Rzid1pHwaC0OsnVytLwDFQTTd3sMdXEHMj/oHjqhcdnP91eXEpA2ExuipmWqVfGakJxiJGhEz
        I3+mkzidvR+YJYdGScaHjmsO8FyT23PhwfmFb3phO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BBCZ0
        qjK1OhEvryp24JbYmcEPtYP+fpD6h0IEJuFpC6iB1kSRHxj+Z5/dTLQZMynhE/gf7afIrQUzHHV
        tJYAG7sN4f3qFHZ5FNGW3eWJeW/alsDqU4jjtomU/ccXDOqfBohBMJtJ3C24mvlGb+24NaZINgI
        pAA8LuM4ArZWy9JAYH/oUxY9lQ9DhXfRkPtcD+Wqh5pv1eDPz0GtB3u6sQ3KpE2w9zC3gPgjL8W
        DWZGeog5Fd3u9jwovgnCuIVtovySLNCjacuFsFZ4CIKY/Hg3AWQy9YC5qGvzKU1cWyI3gWn+NTa
        IMjjw/IAcCikR3vq+0bLzW7NJ67b51dzQ0YJf3WEQFR1jCBFSQ83TMBes+iTrWI4X+Wf7W
X-TMASE-XGENCLOUD: cf0af914-cca5-46bb-8eb0-3d64de80d47e-0-0-200-0
X-TM-Deliver-Signature: 6CFE7CB694A28CC9347557B8160657A5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1666729032;
        bh=AhZYqgoq3h/HY1wPs75NKngCVaKcTSFxWvHBhT9JZAc=; l=6104;
        h=Date:To:From;
        b=fsRSaIvuNClSpynZWVLmMRkf1050NsWJNBmfJ6XzMA3goFMSZMOa+6bbTviGAEVT6
         FUYWPlDwbTsZ2mYFbomIkLwkzud9NIpesBhg4Jdr60sRcFff+9BEKxXGX4QZOLL/NU
         0yhQMDGtAvUf3G4c2TVeIOUTuCOseTStGIaUjzDiXIg+/TrXF9JIMTvmUg6AMJ/jLW
         q+47/pP89b3Vi/wxNwfK5N/m8r2ua6Ai0Kc+ZVX89ypGvgFe8z3bg3yVd8TMcvXjq/
         IoDcbFL9HwURVPT1/RZdfKEIkohoe9jzqxnd98OvGvX2vz9tYNzInMa9Waml5j26rH
         HZkMDuP9wAyYA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz Augusto,

On 10/24/22 22:54, Luiz Augusto von Dentz wrote:
> Hi Igor,
> 
> On Mon, Oct 24, 2022 at 6:41 AM Igor Skalkin
> <Igor.Skalkin@opensynergy.com> wrote:
>>
>> The current version of the configuration structure has unaligned
>> 16-bit fields, but according to the specification [1], access to
>> the configuration space must be aligned.
>>
>> Add a second, aligned  version of the configuration structure
>> and a new feature bit indicating that this version is being used.
>>
>> [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=db3482bc-5b84-4bde-bbb0-41d837955a7a&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-d27a9d4c2c971f9ecc5d00d40d5cd9b45c4b5f63
>>
>> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>> ---
>>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
>>  include/uapi/linux/virtio_bt.h |  8 ++++++++
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
>> index 67c21263f9e0..35f8041722c8 100644
>> --- a/drivers/bluetooth/virtio_bt.c
>> +++ b/drivers/bluetooth/virtio_bt.c
>> @@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>>         if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
>>                 __u16 vendor;
>>
>> -               virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
>> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
>> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
>> +                                    vendor, &vendor);
>> +               else
>> +                       virtio_cread(vdev, struct virtio_bt_config,
>> +                                    vendor, &vendor);
>>
>>                 switch (vendor) {
>>                 case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
>> @@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>>         if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
>>                 __u16 msft_opcode;
>>
>> -               virtio_cread(vdev, struct virtio_bt_config,
>> -                            msft_opcode, &msft_opcode);
>> +               if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
>> +                       virtio_cread(vdev, struct virtio_bt_config_v2,
>> +                                    msft_opcode, &msft_opcode);
>> +               else
>> +                       virtio_cread(vdev, struct virtio_bt_config,
>> +                                    msft_opcode, &msft_opcode);
>>
>>                 hci_set_msft_opcode(hdev, msft_opcode);
>>         }
>> @@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] = {
>>         VIRTIO_BT_F_VND_HCI,
>>         VIRTIO_BT_F_MSFT_EXT,
>>         VIRTIO_BT_F_AOSP_EXT,
>> +       VIRTIO_BT_F_CONFIG_V2,
>>  };
> 
> So this introduces a new flag which must be checked when attempting to
> config, right? But is this backward compatible? What happens if for
> some reason the userspace doesn't use the new struct are we able to
> detect that?

Yes, it's backwards compatible.

[q]Each virtio device offers all the features it understands. During
device initialization, the driver reads this and tells the device the
subset that it accepts. The only way to renegotiate is to reset the device.
This allows for forwards and backwards compatibility: if the device is
enhanced with a new feature bit, older drivers will not write that
feature bit back to the device. Similarly, if a driver is enhanced with
a feature that the device doesn’t support, it see the new feature is not
offered.[/q]

So, in our case:

old device - new driver:
The device does not offer VIRTIO_BT_F_CONFIG_V2 feature and uses the old
configuration structure.
The driver also uses the old configuration structure because
VIRTIO_BT_F_CONFIG_V2 bit was not negotiated.

new device - old driver:
The device offers this bit, the driver reads it but cannot support it,
so it does not write this bit back to the device during feature negotiation.
The device verifies that this bit is not negotiated and continues to use
the old configuration structure.


I tested this patch, it
a) works fine with a new device that supports VIRTIO_BT_F_CONFIG_V2.
b) uses the old configuration structure when working with an old device.
   Our device does not offer the VIRTIO_BT_F_VND_HCI feature bit, so the
driver does not tries to read unaligned "vendor" and "msft_opcode"
fields and everything is fine.
But, if the VIRTIO_BT_F_VND_HCI feature is set for the device for test
purposes, our middle layer asserts unaligned accesses to the
configuration space.

P.S. But, as Michael S. Tsirkin rightly stated, [q]Will a spec patch be
forthcoming?[/q], this patch requires a specification update.
I could not find any virtio_bt specification, do you have one?
That would be great. Otherwise, would you mind if I try to write some
initial draft?
>>  static struct virtio_driver virtbt_driver = {
>> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
>> index a7bd48daa9a9..af798f4c9680 100644
>> --- a/include/uapi/linux/virtio_bt.h
>> +++ b/include/uapi/linux/virtio_bt.h
>> @@ -9,6 +9,7 @@
>>  #define VIRTIO_BT_F_VND_HCI    0       /* Indicates vendor command support */
>>  #define VIRTIO_BT_F_MSFT_EXT   1       /* Indicates MSFT vendor support */
>>  #define VIRTIO_BT_F_AOSP_EXT   2       /* Indicates AOSP vendor support */
>> +#define VIRTIO_BT_F_CONFIG_V2  3       /* Use second version configuration */
>>
>>  enum virtio_bt_config_type {
>>         VIRTIO_BT_CONFIG_TYPE_PRIMARY   = 0,
>> @@ -28,4 +29,11 @@ struct virtio_bt_config {
>>         __u16 msft_opcode;
>>  } __attribute__((packed));
>>
>> +struct virtio_bt_config_v2 {
>> +       __u8  type;
>> +       __u8  alignment;
>> +       __u16 vendor;
>> +       __u16 msft_opcode;
>> +};
>> +
>>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>> --
>> 2.37.2

