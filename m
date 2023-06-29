Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FBE742E29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF2UKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:10:02 -0400
Received: from mail-dm6nam04on2057.outbound.protection.outlook.com ([40.107.102.57]:56541
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232478AbjF2UJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8bq3HzQCj4OZlM4K2Aejq/mj7S+WtTF4N4DmnqTM3l1MgRsRXXjdOYQGpUmPFfQq2c6i2LO7CfSV/R59BwW4LMkshyTP2nij2ESsGUk2U36U7CX6nasR/boXUp4MHC6qzN4MzFCssNoIrILZ2GYV6sYgc9RYWJbNiFk/+sWIckfiu341qLpoMhuxeWQGLkZ2nZeRcerFk0d4edFlkwzfJAdyPf9FG7CbkyDEMdhJ+KSAIkFy39s/V+vwam37uJ4ZtDvOom7Dfa35c9N2tUHzJ2B+j+JQJWjqtH45SoIyLjM0mZxe01l2CI3T7iLvc3pwpNFH69FB4jy914CO7r00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfDyZ5rkgIClu8W5DpdZ0FSq2xuKxf3v7fefJam9/Mg=;
 b=cgaD4FLvlJkbxx7Ewo9ho6B2JAm1679k+Vx+f6KNq2CkVXIZgIzE8CvT8dVVmU4yqTJCY3lULqEiOR3uVyQ4voxp8f2D6LbcloimViSlnAZOTWMPjYNB/E8c/woK/stpRoSEhM95thu9FF3rRHoDcMILAe8m58mMs0kdFHE9HiWGIuFbe+w41OUIZ/or85HPlrkNMvutg9nLEtHLA5pZCRhEQPhSDiUc6hTF6jiUE41x5Gw4ObHokUZbYYFggchOqCs8HsRAawtIKU9zBOGl1Q8iLeBNAzG+rWhsFy9sj4yF32khGjYvZoZgaL3P6CcyODL0W+VfOy9Noagsc3/bNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfDyZ5rkgIClu8W5DpdZ0FSq2xuKxf3v7fefJam9/Mg=;
 b=ERpdnxc48GQeVq6cy4qQO457fOfBVfDNyWBE7LypVH45mbtEDAdzgHzLYildFEBdn2ePKfH/KCvm+X/KyPXiyMBX74z7uVvXvyCV+WxP1dtbW3k1VpNHQIPdPa0/60CiP2VZgyVOO03rZsVZgYUs3YjBulAiXRiA7deWm8I7s1+iFV2c6IFiJ1YQ5uPmOUwVKPZrYSTy3C76DwKoT4Hr/5ZNIRlSAtnnfid8ILnE3a8mZn3xE6sQvIoaiS9llNoouBOE63Vh6hhWFItJWElGyLXUgWbJQwqfQssB4QHQW3MjF91WhaLgIo4XaYkReSTCfgxgB9s/j+tm+Cy4CcJWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 20:09:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 20:09:47 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
In-Reply-To: <8b8d8d78bb8856b933ee92ba2b9c8a256f90d29b.camel@hadess.net>
        (Bastien Nocera's message of "Thu, 29 Jun 2023 22:03:05 +0200")
References: <20230629172041.3771-1-hadess@hadess.net>
        <87wmzm9k7l.fsf@nvidia.com>
        <8b8d8d78bb8856b933ee92ba2b9c8a256f90d29b.camel@hadess.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 29 Jun 2023 13:09:38 -0700
Message-ID: <87mt0i9gjh.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 113e8c88-c6f5-41f0-d1d6-08db78dcc964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1scFMZIoS7xFFvktFBbttwKw5mgrZbQVTBfI+OzbeU5TgJzTWVTUKdzKvRXPDEvHFSHdeS96hkbrEmw0xtiHnLUwWWZpCxuy2JJrhxfJuzcOO0WWkamHlWV4BCiVHQ4pI/WYIaQY0I3CojvXndAOxAcykMHnvhuaVr+swwrIyhDT3byYg2iE+OX35RhtNb2T1c1PfGfJWtl1mHoXPSQpblFj3mRlqtFBOJnqSz+XJUU+atD7mnk3tDvhOi64O3pUMxgxlcbXdT0lYYV9/DEnmH+mdLyeOanSI9evmNU/gZsU+8bz7/7YTAj65e5PPJs4qCdvF2Rhn1MRrL2Bn7VVhYvj0B9t7ffEnF9BWM/nUnNsGzmPfFIkNHV6o7PGC9cVcjdir7+TZR1VN/i24j9ZV3VuCQo5Ijs3fGVK3/3V0xbrVi4/iF/iI086ViZSTl5uDlvdJvihDRDOSzPcRfGgWJem3Z/QNwGKC+YrCYYACgfLTALbrGnPYCPcUZW7gf62yir7mG20OD1pNMsVOIHnrzgfQQdM4cd+67yDvhxvbk2uOTeOIHA435WzljS+/Mtt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(47620400004)(451199021)(6512007)(8936002)(26005)(66556008)(4326008)(66476007)(66946007)(6916009)(86362001)(316002)(41300700001)(8676002)(5660300002)(38100700002)(6506007)(36756003)(6486002)(186003)(2906002)(6666004)(83380400001)(52230400001)(2616005)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUxkMHFzd1J3czZvN1p0K3hqRXpzNDhJUHlkRHA1bEVGQWFqYVhQUzlsVURx?=
 =?utf-8?B?Y3NKdE56Wk91aHVyRDhxUFhXSUlYNGhOMGxaUC81YjNLNkZYY2Z2YnpvM0I2?=
 =?utf-8?B?T3ZUKyt6Mmw4dk83cGVFcXU3b1ZhRlpxanlmNlNuUGFvb3lvVTBPdWJmSGN1?=
 =?utf-8?B?Q3ZoK05JeHR0RkV0bWtnQVFnVkgzRWs5QVo5NDI5dm9UclFKcHdBcVhqeE01?=
 =?utf-8?B?U1lOZ2xnajZXSnpBbXp6emNKOHB3Y010dnZ1ZjIzRnFsb3ZNNmxRZjl6d044?=
 =?utf-8?B?YWhZTTdOT05hcm9laE96Zi85ei9HeU9MNTd6Q3UyNWZoV1h6NWlXY2dRaFdm?=
 =?utf-8?B?YlIwbFNKNWNTT2RyNDl6YytianU0K0ZGUGxGdjJmcnUwU0lIWW4vcmdLQjlk?=
 =?utf-8?B?T3J0QnhCdVhVTzJiSnBDMHo5TGVLUWRXU1VQS3R4UldMa3I1ME1NNFowQzdk?=
 =?utf-8?B?SVYzeUt5bWZYd2VuUEMyZ0Yxemg3NjZpVFNsMmpXTUVxYk53eExHaDlTMXkw?=
 =?utf-8?B?bHdmaFA4dXRaMS8zdE5DZUpjbm5kTWk5MS9GdzJ3NGFibDJiVWM4ZmlXRjZO?=
 =?utf-8?B?U29rcTFIeWhTWnR6RWVqckkwRTk0bG9OSTlCdzJQdTBheFhINDN0SCtoOXIy?=
 =?utf-8?B?NlpvZjlRR3lRbFMyNDl1aEM5dUgwdDJobDNBS2haT3NUSHNYSTdqZENFKzdR?=
 =?utf-8?B?ZUk5VzcwWjl6SGNyck1CblZNbzRTd1pGK3JoN0hWdmtzZXdOdVRvNmc0NHI1?=
 =?utf-8?B?YStNYlhJT1FWODNoZmYwYXNyTTJOTWp0U084cHJZZE91bkFVRWx5YUx5Vlk3?=
 =?utf-8?B?RGpoTERZQ2lGRWtJRVppYWJIQmtPZmw5UXBYY0JjSHZBbk5qSDB0NzhGNzJX?=
 =?utf-8?B?YlJnczEweU9LaHZkaDh2RTdTVFVzMEZzU1VrUmhTWTJtSmNHS3kxZ1paaDNm?=
 =?utf-8?B?MXlKY2ZGeE1kL3V2UVBiT1RjbVRWQkx5SCtZZzFtNGc0RS9GNVZXRGNheS9T?=
 =?utf-8?B?RU1DaE9zOEozUlkwNk9HektnVUlkZWZmTG1uSnRVTVltV0pvcVZJMmQ5YjNN?=
 =?utf-8?B?dGhWWVB5d2ZSWDNENWtMRWZpTUhWQ0hsUW9CWHlOZzhPUUtiTWRGZENUczhZ?=
 =?utf-8?B?L2g4V1BvZm1mQ3piUDRpazlvb2V4ZWd4aE54VHU4UGNZbXhRSW5aaVdhWWdn?=
 =?utf-8?B?VlRhak1nelJVVGRJdGMrR0VuaHBvdHhUUUIzN2x5ejIxYnhzaklYWlh6MzJL?=
 =?utf-8?B?MVlaWU02MDhyTk5SSGxlUVlpbDV2VjRWVWY5aVkxdjlmRnBsSWd3UEg4eElP?=
 =?utf-8?B?RjJUeFh0YzZUZWcvalV3VDdqYXpqZThCS0JUaDdjcHZTRUwzMURxNFJoUUN5?=
 =?utf-8?B?Mld4YUE1UnFGWDUyVGVaZkNTUDMzZFFDSFI2cXZySS8vM0xXemFETlZJbklN?=
 =?utf-8?B?K1laQmNWb3ZXckFlMUFVNENXYmhTQ1l3UjV3N05LUldLZzJTV0RWVk5SL1Nv?=
 =?utf-8?B?V2NtZWcwa0xlOFd6MmlNVWloY1VJUUsrM1JhQ3NUK0wwam1YM0JQTkt6VmNW?=
 =?utf-8?B?NHZzSDVyTGpyMDB1YU96Vk9BcVdCeGlLRmo2YVBSSUVVdGdUR2oraGlkc2hl?=
 =?utf-8?B?UnA3d1duWE9UNFBTVStGck1oV1F1T3dIaDRETk9Pdm5hamhLT0sxa295MjZO?=
 =?utf-8?B?TlpMaCsyTy91M20yb0VrTFMwL2hNQkdVNWNGRndQVjVsNHdOVEF4NDBkYmtx?=
 =?utf-8?B?dCtuYXJSVFd0ZVd2WXVUOFNqblhwbGZrb1ZocG53anNweDd6NjlTNGhxUWNj?=
 =?utf-8?B?OTFtNEcxWTR1NTRud0RmZnFwcUxBODNtRWQ4UGtBZVhwdlk1Q2FQOUJxdDEy?=
 =?utf-8?B?My8xRUtDY0VMSHRQNEJlcTgvNG5LdEhUaXV6aEJnMkhvbDdXa29BUWZ5bERM?=
 =?utf-8?B?VzdlOGtwZ2pZcm5wYUJBMTcvblFzb1pwNkFodHg2RUpsOWpaVW1vNk5ndmla?=
 =?utf-8?B?YmxBRGRuOFhDcml5VjZDNG0yZkVFNTRJejZTc1hlSVY4bjZUcFYxa2NKSzhZ?=
 =?utf-8?B?N1R1S2JlclQvYUdHYlFVMVpQVnNWaTd6VGJDSkg4WElvRDVKd3JFZ3RJQjBr?=
 =?utf-8?B?QVpBaVdnWVg2VnI1U0hBQlIyenh0TkMyZWYyVDlpUVZjQnJZRzFteFM0ZzF3?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113e8c88-c6f5-41f0-d1d6-08db78dcc964
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:09:47.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I1ATN9s2OaPg/2KC+xBQ6cJvCd+T7s/y3Hry373dnCUac4Iu/g97d0dOHPo+tph5r+axSz2kFUjxYIq4nIBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun, 2023 22:03:05 +0200 Bastien Nocera <hadess@hadess.net> wrot=
e:
> On Thu, 2023-06-29 at 11:50 -0700, Rahul Rameshbabu wrote:
>> On Thu, 29 Jun, 2023 19:20:27 +0200 Bastien Nocera
>> <hadess@hadess.net> wrote:
>> > +static const struct hid_device_id steelseries_devices[] =3D {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ HID_USB_DEVICE(USB_VENDOR=
_ID_STEELSERIES,
>> > USB_DEVICE_ID_STEELSERIES_SRWS1),
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D STE=
ELSERIES_SRWS1 },
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* SteelSeries Arctis 1 W=
ireless for XBox */
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(USB_V=
ENDOR_ID_STEELSERIES, 0x12b6),
>>=20
>> Shouldn't the USB device id be added to drivers/hid/hid-ids.h?
>
> No, the hid-ids.h is only used if 2 files in the hid directory need to
> reference the same device.
>
> Since changes to the way hid drivers are loaded, there's no need to
> blocklist the devices in the core to handle them in a driver, so
> there's no need to reference the device in another place than the
> driver itself, so no need to add it to hid-ids.h

Makes sense with the fact that the device id is only needed in this
source file. For example, you don't need to recompile the steelcase
driver module when introduce some other unrelated device. Thanks for the
clarification.

-- Rahul Rameshbabu
