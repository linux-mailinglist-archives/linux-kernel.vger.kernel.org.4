Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F26CFD89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjC3H7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC3H7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:59:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8135AD;
        Thu, 30 Mar 2023 00:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/3oosRYL5Owmw9p65TbMcPml7I9mg/TKp52KJ0RWof2Se9f6QX+DukfPkkGbE2zU4SsUl58P5QSNaHNu6mnLGY7pP9J7wiV8l6y5r46BrpMwAWmZNq+Ygispo1m0oQxzl74aDrbo0vAYwMoTV+YggGS0GR6Ig0jvEw15hXsVdr6k4LMHlUZeO1hyIPUoZd7bVsylQwYHfAdo3eR+Dkj+7v0i3gp9XWLSn79IUahTLaJfMzId/12cspLPOR2+J/OV9UlkBEbZaN2xVR9hf41xRu7IDIfUwpJgXs1wT8+FjaqyCqRnUMtLsOKBQjf2ZiKrKbHsWBVW3MGrcREfoDojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz9i8yo7Bn0TKHIatSBYiwp8NwJXluUZhmwj9JESIKM=;
 b=QBNVOnILJsT8u8ock+1bkNlmxmIQNLho6hReVZHm2jlGxz/sIQJzI6yUzU5n457vIT1QQoXqqX1/9ZODsz+LkF2oMczG7/lzXtYJxldU3aj1307iVBJCqczuXLvDt/gk7jbMId/gyYDIEaCKFkpwytFyDq/95Gwg5AP1uitPRWZxQKIaDPmH3aoRR0Nzp3+1yagSWpJN2GZGr48EHmPRbcopOFXQ+jEnPPp4Iet5qnuXzy9ZP2Kkkgbeb9OhwbzXAG/RDWH0qg4l0ErBKZMret9HUN/wgHNJle83XPQAorfndn4BMvaJ1JcsivOleEsZv3vDar2Y6WjsJ6Gjxhy75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz9i8yo7Bn0TKHIatSBYiwp8NwJXluUZhmwj9JESIKM=;
 b=tu5eNkRUsbNPwyDo2VFxh75H4MUJA+TBs93NcKVQSap0HSrZhfto/+ZS+Dx0giE/5qlMU1+8wi4ZtEuWPumwoGo5jc9JNrv7+/+a30ZPcIxCPPSnxbSg1pHR2nsWWq/c0JME/vJdYOVBWQSAxSfV2I7mPFNoWuBnq/UNtgk/uzFx413qyMDNwlomdiVIG9fhuTPaYuhrifqodWBdsiG5EsBR1Ff4BF7k6PWpTJZyMFZ4aXrIDyllcLGnm2oj4b0pywoDVIR/s0nNYd3TYKqxUEW9k4pjR1tsF4FgKFZ1c/8EEfy6cv3HmB9ARWJhWrYa/7lYs0Z36HzUmPSsbqhXjw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 07:59:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 07:59:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: target: return -ENOMEM when kzalloc failed
Thread-Topic: [PATCH] scsi: target: return -ENOMEM when kzalloc failed
Thread-Index: AQHZYrDCMl5QmR9jkkuWZcIAgUnC868S9ZkA
Date:   Thu, 30 Mar 2023 07:59:03 +0000
Message-ID: <73695d8e-a779-3c9c-5a46-b5a23381dff2@nvidia.com>
References: <20230330023834.97455-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230330023834.97455-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA3PR12MB7923:EE_
x-ms-office365-filtering-correlation-id: 5f7e983b-14b6-4a46-1c00-08db30f4a0d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b41QYy59EwgmgaEu8wIPCZIO+iPtJifTUWtno+xLS0/V1KWCn9S6YOeLan5fKjOiimgS+Yc8x+Wbn6o/L6oAZR/yopdpquzFBw7Rx5v1rRIJ9d5WDE6OBNaErqHSJKHcDeDOIByHMHgmzTcUcoxKTe8xDuezqKZfrh6wX6iSexhKkKguKHtmLPjAqzU5T5pfr5m++TqfDIRnKhoBDhubzcGT8XqzKvvTEWBAImfuX+JgV4GVmI56JQzCLJdAAhFYx+Zz5dsF0Lb6HyRVrJ1GzdYU+cFnm2rHw8tfkHtPTjxbIfIhSM0aw9prjAL0CTDLqk3zNzx3vreQKVULht8jopStjmwwzXPLqBOQYMUPFSHW+IoTXvtbTVpNLSLhFsAQ9JBzUTjNkmO+v4JnjRr5Ub5CulAtaWWVJg3l3eI+Z8VfmrLK/aw0dz1U229zxTLzStBFa07lBOPEkf4+WxLfpuM7g0UdReQGxWwBCUDcwn08r0DxbmUlN4FuF4PnhVrdFSiE35m6zqh8Tv3vihbM1TZgAxiSdbiRA7XSsLfhvhE1qFa6jUMykJiun/KWk9+sspeDbN+6LdeDIHqC8z4FV6amnw7iodHYlm9boisRCWUd+Q/MXufZP6iUz82pXftRYFKHfQM1D2sj1ZFh7wCU66zX965+JK73Hi2XGOezS7zXSQnOvKLmix+JWwSuOyt4tF1PBUPmMhTdWANdUrWw305uxWwbpwxRezSDgJwTLD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(316002)(6506007)(6512007)(122000001)(86362001)(8936002)(5660300002)(2616005)(31696002)(66946007)(6916009)(64756008)(41300700001)(36756003)(4326008)(66446008)(91956017)(66476007)(8676002)(76116006)(66556008)(53546011)(186003)(54906003)(38100700002)(83380400001)(478600001)(38070700005)(71200400001)(2906002)(6486002)(31686004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2YzNElDZWF0QkhEdzJRN0RSUVZuMVNZaE0vRFZ1cys0SGs5WThRVm01aFBo?=
 =?utf-8?B?d0VFUW0vdkg5SlAycjhGb3lBcEFrSXp2aDNuQ1pmSU5WRno5Sll4dWRTSTBJ?=
 =?utf-8?B?a0lnSjZHalhKQmVYc2w4Ykhxc1JwM0RHdElyRUJGVnZ0RHNQUSsweHdDSFFM?=
 =?utf-8?B?VjJkcldVN25WZThQdHNRZlphV2NLNm93QWJzendZWUwrNFp0K1llTGNBQVZ2?=
 =?utf-8?B?bWFtOXd4dGhQai80VkJmc0d0ZGcrcVVQOXBhcmdBS29xNDVENlAxeVNsUUlx?=
 =?utf-8?B?dFd4aERkK2JqeUxScUx4ZGp2cm4ySTRLNjI0ejg3WDlDaDcxMGwxSFN1dlNs?=
 =?utf-8?B?Z1R6MkFhRngyT0txUWRtUWI1VXNONmJEYmpKdXdxSlhBWlYxM2lUT0lFa28y?=
 =?utf-8?B?MkI4RGRiWUFTSzlWcGZVMWVzNERVOHVtbnZOdm1KRDhndVkxV0tQK3FQdEpZ?=
 =?utf-8?B?dmhxODZET2JFTWordXE3emlnNE9pYy93d2NvSnBJK08vdm9MYTlYSnJlb2Ny?=
 =?utf-8?B?R0lmZDdqUVdMaDNCcDR3cmczSTRNOUR6UUxKS01FUG9EaGZURjd3QjNrNlBh?=
 =?utf-8?B?WHo4aTllNUgzWWFGTGNBY1QzRUd6OEc1VnRSUFRoYzZiemhTMHdKSk44U2Vp?=
 =?utf-8?B?MVlHMEFNaVNqcVQxNUpkU1hyVGFVcjVXeEZuVVBpZUViWWJOMW1zWkFUY0RT?=
 =?utf-8?B?TzRUQ1cwUU1iTnlTbS8wOTNxbDY0ZW5reGp2YmZaM1hiNHdhVnRWb0E3eU1C?=
 =?utf-8?B?dmowbUJGM2gyWmRTMHhhUytkNWhjWTlhTkdDUHd6S0hJZXNwTktndVJFYTEx?=
 =?utf-8?B?THBBS3lSMnJlSXhlcmxYeVp1ZC9aZytuaHNHUk1hZ1JLQURuM3ZWeFFHbmVD?=
 =?utf-8?B?eFY5RnluMWpHKy9iM2Q3ZVlQbk5jclcxTmdoOHQwOXJsSXAzYUxCUHVwczJq?=
 =?utf-8?B?S2hzNU9DckZZT0lyc0JDYW1DWk9pTDg4bzg5bTJSZDFvaVJ2cXZJVWJ2VzBm?=
 =?utf-8?B?UlZIRDZtODVCTUF6OVFYbWxrNnF6TUNVZ01DeG1HYndkTnpDdXhQaThXdFoy?=
 =?utf-8?B?R0dqY1JEaTFqNmtqYUZSQ0VYYW05NThBdS9iVi9ldER4TExBZGU4UGxKU0Fl?=
 =?utf-8?B?TFZFTURCTW1aWXpLeHRsNjZzQXIrMi9oSDlEK1cvZndObnVsY01BSlRqUzRR?=
 =?utf-8?B?bWZUNHhpQ2dPRlNvSGNBSy8vQmpGUjRtVmRtWHZPTVNxQW1ETHJPVVY2eTc4?=
 =?utf-8?B?bUhQdnd0T0tnZ2t5bmdsQXhuRnpkKzFNZEtMMXhoL0lLbDV5KzVJS2RKbGN5?=
 =?utf-8?B?MEYxTktaUGdMSk9NYTBCeHc2MjBxa3JIa29EcWZBU0x3N0RkY2V0MjM5L28z?=
 =?utf-8?B?dVk3bEwvenkrWVdLMGgyNk5lanhvMXQvbCtpbzJVT1UvWnF6R3NFK214Rkto?=
 =?utf-8?B?WXJLTFU4cWU1WldUY2gvM0FxSUROeGR3Y2NCVWZzNWR0N2MyNWJXYXlsNWEw?=
 =?utf-8?B?S3QxU1dOUzAwejhFb2RKYXQrc3hGSlZLK0RYNjBXN1FvNDQ3WWwvZ09lSUJ3?=
 =?utf-8?B?MGloWFFiSjdSc3lpMUUwYzVIM2htYm5PSnBzcU1DSlIvRjBKU25XK1BxTG95?=
 =?utf-8?B?QldvYksvZGNneHB5UHNybXNCQVJUZU02WnYrZGhqOVVwY1ZERnFoOWIxWWlR?=
 =?utf-8?B?R3d3LzlYSGFiaVFYSU9LUWlMRUZud21wQytPRWlnQ3Nqdk5MZjJjTkNURjQw?=
 =?utf-8?B?aGc0QzJyNS9xbGo1eXVpMUMrY0d6VURLazRxeU1EY2VvVEhkbU8vdnh5OGNm?=
 =?utf-8?B?QjR6UitneE83eFdESllYWWJPRzR1K2Q4QnByVW1DZnJaQ2xmeHduRzMzZmI4?=
 =?utf-8?B?WjY0bXRQQ3dWbjZMMFQweWxvalZUSVNKRGFQTmxqOStZV2kwazVnUDBQSGhm?=
 =?utf-8?B?bUZlMzlSLzNOWGlRb2owQWwrdUJwWGJ2UGNyK01BQ2sxVk4wS1RsM1lLajA4?=
 =?utf-8?B?cE9mcDFKMDlrWjhBa0wyK3JKeURXbkprcE1wUkZFMU82MEJXOXNDVmt2RUo5?=
 =?utf-8?B?ank4SE94RFJmbG1NdTU5d25HOFY1ejRtVFM4RWlNRHQyZUtZVDdJMEtZMHhU?=
 =?utf-8?B?dHlsMWxyTHBBclcrVWtabVB3aXpmZWFzSkNkbG9IUkExTmdITVJGVGpKU0pv?=
 =?utf-8?Q?Vmk7QY07ZvE8MKCpqUwbzB7Q/DabMJtQNOEH5ltFHNCn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE7E44BA502B44AB4AA6660DD373FC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e983b-14b6-4a46-1c00-08db30f4a0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 07:59:03.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A72Hl7KPGInRzIGZIm8NGaBc4f7U4/BzoB8ZKJ9LzH1fzzUPsX9o6uvghD4JKJ8INiZmnmDmJILjOTkI+7uG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8yMyAxOTozOCwgSmlhcGVuZyBDaG9uZyB3cm90ZToNCj4gVGhlIGRyaXZlciBpcyB1
c2luZyAtMSBpbnN0ZWFkIG9mIHRoZSAtRU5PTUVNIGRlZmluZWQgbWFjcm8gdG8gc3BlY2lmeQ0K
PiB0aGF0IGEgYnVmZmVyIGFsbG9jYXRpb24gZmFpbGVkLg0KPg0KPiBkcml2ZXJzL3RhcmdldC9p
c2NzaS9pc2NzaV90YXJnZXQuYzo2OTEgaXNjc2lfdGFyZ2V0X2luaXRfbW9kdWxlKCkgd2Fybjog
cmV0dXJuaW5nIC0xIGluc3RlYWQgb2YgLUVOT01FTSBpcyBzbG9wcHkuDQo+DQo+IFJlcG9ydGVk
LWJ5OiBBYmFjaSBSb2JvdCA8YWJhY2lAbGludXguYWxpYmFiYS5jb20+DQo+IExpbms6IGh0dHBz
Oi8vYnVnemlsbGEub3BlbmFub2xpcy5jbi9zaG93X2J1Zy5jZ2k/aWQ9NDY0NA0KPiBTaWduZWQt
b2ZmLWJ5OiBKaWFwZW5nIENob25nIDxqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL3RhcmdldC9pc2NzaS9pc2NzaV90YXJnZXQuYyB8IDIgKy0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3RhcmdldC5jIGIvZHJpdmVycy90
YXJnZXQvaXNjc2kvaXNjc2lfdGFyZ2V0LmMNCj4gaW5kZXggODM0Y2NlNTBmOWIwLi5kM2E0MGMz
Y2FhZjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3RhcmdldC5j
DQo+ICsrKyBiL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3RhcmdldC5jDQo+IEBAIC02ODgs
NyArNjg4LDcgQEAgc3RhdGljIGludCBfX2luaXQgaXNjc2lfdGFyZ2V0X2luaXRfbW9kdWxlKHZv
aWQpDQo+ICAgCXByX2RlYnVnKCJpU0NTSS1UYXJnZXQgIklTQ1NJVF9WRVJTSU9OIlxuIik7DQo+
ICAgCWlzY3NpdF9nbG9iYWwgPSBremFsbG9jKHNpemVvZigqaXNjc2l0X2dsb2JhbCksIEdGUF9L
RVJORUwpOw0KPiAgIAlpZiAoIWlzY3NpdF9nbG9iYWwpDQo+IC0JCXJldHVybiAtMTsNCj4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pbml0KCZpc2NzaXRfZ2xvYmFs
LT50c19iaXRtYXBfbG9jayk7DQo+ICAgCW11dGV4X2luaXQoJmF1dGhfaWRfbG9jayk7DQoNCnlv
dSBjYW4gYWxzbyBqdXN0IHVzZSBnb3RvIG91dCwgaXQgaGFzIHJldHVybiAtRU5PTUVNLCBubyBi
aWdneS4uDQpBbHNvLCBpdCB3aWxsIGJlIHVzZWZ1bCB0byBwcmludCB0aGUgZXJyb3IgbWVzc2Fn
ZSBoZXJlIGFzIHdlDQphcmUgbWFraW5nIHRoaXMgY2hhbmdlLi4NCg0KaXJyZXNwZWN0aXZlIG9m
IHRoYXQgOg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
