Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E95BC347
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiISHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:00:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C96548
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyxJrEh1Q9891hhGRZhUcaW3dldOmYO17jW5knke8z8Niw7gXCHmnIaGDcrp3O+u18kWmWbyj0GJkOJBh87yxV0Hsz2xx0l6NyFqPksLm8Ig7+cyB1dasVViKpuZRyVRIuhq08++W2hV1ikyZQgpXXAUrTLznYLKWC/FCQd/5zRPUBTWNaAUcVjDpuBe7tG2XHOOXek2tBvjQM0NPzux9f8TFJZ16AxVy9ZRn8JjJVBb6lHFIj5M9z8WHEPooXMGOGqYPyPF0vYHAY694QmFhemX0dEoPyEsvs53lt7AmH/lYPJHDlLfQUmVUOnTbKUHqXKH5GLp4Glz4Do0JRN6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YFqpvZi17bQWFTpzhNX+jK6qpaK0AhWcz1tcQ9+AvE=;
 b=i83EKpI8wbXeXztaqzEJIGEhIUYsAjo8OahpmygOTvhgFqtUXidhCp3O5Oi0EGKcBNbwK0BkQ2w3FF6Fym+amyAt/zR2tyNwFAn0DQh68rYtnKOOlSOtM6p449EGvd6M03Tp69KAvsNe4AETdcF4olXmImewlhCU3uee0tYaP3TQSOofqP3UjvPoSt1W9RtzYb1Wi2i7rAAGQ2nzwRYlLGB26hSN2CpL6B60QfWAnitPmKiyJ3UCIpfpGJAyOoHI/DMOLb9gPZftfcNpJDpFksqSWoFRKgpwFH0+xbd4jZauB2ccYTFe5ERxPTx/CiF5qINtGgwijHR0s8mm+0mpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YFqpvZi17bQWFTpzhNX+jK6qpaK0AhWcz1tcQ9+AvE=;
 b=E3pc3aMdOhoy7XSHU3Sr/gyH1Lsgr415bkjIMBA9t1GS5CqV6zjO7IDpKKPUxKtLKFTm1N1qOJbYy/qRZ1N8W+TV1/ZI9BmqKJGYHtZVWLNOxf2Ef9pKP8BCHwgeIw/+gPkXpBIWVDwo5IUf63XbEzhkIbgGU2fw/4UJgmT89/ukNZLZlwUW4S1SRKv0WingsPYAgv9wQ3W3cuALstUUcNb99BwReyDuJz8UYl5mElKSPw9Fxw7pE8XNuNSJuu8owNp9Q2O4WffrRvXvCPfv0jzlDhybHbIACqQIl0BVo9nIJjEh0Z0siStDXa33jl9GBn5yeuaPBUUMpLpbk/3weg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 07:00:51 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 07:00:51 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: RE: [PATCH 2/3] vdpa_sim_net: support feature provisioning
Thread-Topic: [PATCH 2/3] vdpa_sim_net: support feature provisioning
Thread-Index: AQHYyOBQzsGz6EmSokS0j2ZwNY0eca3mWRrg
Date:   Mon, 19 Sep 2022 07:00:51 +0000
Message-ID: <DM8PR12MB540061EF3C91A76CB0F9D9B4AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
 <20220915085048.12840-3-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-3-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH2PR12MB4086:EE_
x-ms-office365-filtering-correlation-id: 584d40c4-bb52-4bf4-7473-08da9a0cb048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63qTuAXn/Eqat7r1KN6R/7/itYJAegYqVTyUNgfDCL2vnmtyQqJVVlRWFMabG0PmRdDApGW/CV3kAt9vHx/zGITDvdTSXBp//B0J0KJ0XwsoWkveLRHVg+ZaNL+HPdCF2RWpoxXgrVRhKPZa63RYejdO9rk0REoBdNIPIXgQUv+9b1XbrQSYhry2RFl+2EEZAUoBbHrQwjOK8oQkuP28p1d11oQKuR+6d3jhe/xfiMaB2XUkLAKdB2uroaizR5Ip5l2VOnbIh01vxruJrEY5q7H+Nov39j7bcpkvjMpJPDS1T1pJ46zkhGALOSE0ARfr0VrFj8hmks6fGseXT/MJcJOBZJBWWh7CQ1b3aCssWG6DcHmsjTY5TnXcE+Z5fjcn1VIKTQOBCSgX+wAOEQ+DYmmi0dZwivJG4YVKRKG25WMcEkdCj4fkBguql6Vg2Y+HQ39nyF08/XDU7QtcNRvRilNWM2UyWRAOiew7spxdej+H7jecZAR57q+mA+j5ZRVctixwGd1/Je7of0qul7ho0HT6j6poF73QU/4fRgOF6wLs1HFeqSXwqdl4K/pdIPPrPmfGOnBRsXUhhycoQG+7mv73xZLJjFFf4AYnvNLTYHiou1UyLn4T/TA+DEqLuda2oFqERjjuyk4v64hA0HmV0vCwBqGzpNpEzaiyoQzLSlIUdYHPSxFjfZ9HLEsLkUt7ZMxmHn42kLALtWoYDqfRRxGpNCqOUdOkQc15bxx+ddvQIMJJtSlsgO5/xUhf0WEoo7M0kIRPpRGBnQuzR33cIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(76116006)(66946007)(66446008)(5660300002)(8676002)(4326008)(66556008)(66476007)(64756008)(7416002)(8936002)(54906003)(110136005)(86362001)(316002)(33656002)(122000001)(38100700002)(83380400001)(52536014)(53546011)(7696005)(41300700001)(6506007)(71200400001)(478600001)(186003)(9686003)(26005)(38070700005)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NNaVM2TW45dmFPN3hrR1BMdjBLSTlSNjg1T25RRHcxN1padk1tSFFYck5X?=
 =?utf-8?B?UWdYYzNVOVhFeThBNTdPQnlJWFBsSmw2cUdaVTlQQnFEQUhxQW5BeGs4cHVl?=
 =?utf-8?B?dmVpc3IrWHgyQTJkMDRPcW84RDVPdUZRWGJNVUVBaXM0eEozRDlabGg2Y0lk?=
 =?utf-8?B?NDVrS2pJSXVMa2hTSkdRbXA5L0drallhaXpsWjFJaTBJdzkwd0o0UTJSVHIz?=
 =?utf-8?B?RWVHMHV5WHdGV0FDeFplQ2tmcE1LVFBGUTRIaUdYRTBMSXlmVnZ5bklNUEgr?=
 =?utf-8?B?MkJ3eXZQbHZnRlhHVndRRkd5NTcvdzFSOGlIbW53dnJ3bUlKMC9PeHJrS1pX?=
 =?utf-8?B?YXJrZmxjd2JDdDdKRHlkOE4zTG8wMUxJcVArM3ZqVjExWVR6U3UvalVqQXdI?=
 =?utf-8?B?dVZ1YmQ3cDdlaVU5NUhwNzRCTkRuN2thMk5wRDB4N29GZUtHOVVXZUhqazV2?=
 =?utf-8?B?M0dhYitYclB3Ym5oYlNjL0pXaURxQ2dKRU9JZ295VEFSWms3dW5ZSGpvbkhU?=
 =?utf-8?B?VjJuZkg4TlZTVkVIMkNGdnR4ZWRNZVl1Y0lpTlJkZ01uL0dsNFdpcjBJeXpz?=
 =?utf-8?B?amtHQ2JlR3duMDdmV3orTjVkcW94eFR3RGlYeTRFazR0NnpCMStPaWNKVFNx?=
 =?utf-8?B?RytsYlByRHBVTVdQY3h0YTQ5ak5TQ2ZaMVZDbUNsQ2JtR1dkTktuY2Jod1Fn?=
 =?utf-8?B?Z292Z0ozS3pIZ0dpcURlUnNHQzh0d3hNQmt2RkMvc2M2cjl0TWQ0QlR1YlR4?=
 =?utf-8?B?S2dQK0pidVY0dEVORkdVTlJYRXhQWmp6QUkxTFBETG1xVzV6Z1dsVVFtbTFw?=
 =?utf-8?B?djBSMzRrSmlvSzQ5ZWlSK1NnK2ZWVy9WY0lQc3Bmc0xpck9LSVdualVtc3VM?=
 =?utf-8?B?SHM1aDgxK2t0VG1KOS9UN2RNTCsyKy84Y3NRTmpYOXZaaWtzamtqYTFLV2FK?=
 =?utf-8?B?dHlXVEs1VlNKRVBhZEMxNVdKbE90VUpneDB0Mm9pdFgxaDJlZkR0R043enR5?=
 =?utf-8?B?QW1PalBVNndkZGhCa2Z0YlNCZVFYUjNOVUF4V3pKbk1HTWVvVW1xelh2b3VX?=
 =?utf-8?B?UUJyeUtTd2tqWjRpOFpUeTVhcVFOcWZ5Z2FQVFZlM2VJb3BNdUxWclk1cmZG?=
 =?utf-8?B?YkpzY3VqL0xucC9mbThkYnpIcGNjTkJlVDZuKy9jbEc5ZGlvZUpTMWh3akVv?=
 =?utf-8?B?aENGUUFmUlpsQVVJL3FacHdRVnhkZDR1R2JLc0hqdUtoVnI3WWJsWXlpdVlQ?=
 =?utf-8?B?L0tkTnY0L1NOTkt1eC9Fazl6K0pTY0hFTXpiQTU4TE5UMWhGMG1wTDZURXE3?=
 =?utf-8?B?WmU3OUZvVkZCRDJ0RVliem5MbE5wWXVkMi9SNk5neTlBRHpTcTQzblZRVk5H?=
 =?utf-8?B?YnduUkxBMFBZNjFiaFVJck51anhVa0RlVzdhZUlvQUxYSGFiaUxWVGxlU3pD?=
 =?utf-8?B?N1pwbGFLVU5STk9wNzFZUjY4N0tNSHJhK2FrekY0azB5d1Iyb29IelRQOUlV?=
 =?utf-8?B?TWtaeW9VdmtudXNKeFVXNkE2N0RZUkxWWE5KVzFXenJJSmU0YXpLM2FUVENU?=
 =?utf-8?B?Q081VUNVVE1KRGhDNjRmMHMrZnlreW15WU5TVzVTaEYya2w1OGt0enJDWnpW?=
 =?utf-8?B?dmZuTUY5NG90aDVwUGR1Rk9VSU9YTThMUU12ZFRNaU80LzRQWGJkSFM5MWpt?=
 =?utf-8?B?bXhjZHZxUUVSaW0vZWVUVGo0bUxwMWhtVDlUYXI3RXJ6NUE3TmQvcjR3dG96?=
 =?utf-8?B?Q2V3WFd5ajR4VHRhL2hObFBXV1BwSzFBejRJdmlzTFk0RFU0OVNsYXd3ejRE?=
 =?utf-8?B?Z3NnbUFhdjRINTg4UGhjUUR2QzJNbExFRE1ybDVQQWxMOVREd1grYVQ3dnBT?=
 =?utf-8?B?NFVFSVhydnp3eVBUWW5KcEIzbDBlOGo2NVNaK29sRmcyMTJPWFU1RUJpQkFh?=
 =?utf-8?B?VGl3VWtOQU1KTGtlMmlRclBjS0RtVVdBaER0bjJWdlcxMHhpNFRtYXlBOFZD?=
 =?utf-8?B?N2FEcnE0MFFqZ3pHNWFxYmJiNWt2NW5wTTVqUTVhbWVEY1N0Q1d1TDJvb2hU?=
 =?utf-8?B?MFpKQVU2bS9LSlZrZ090bGZHQnV2cmJxY1pFUmVablJiY1AwYU1EakZyQ3FN?=
 =?utf-8?Q?AOx8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584d40c4-bb52-4bf4-7473-08da9a0cb048
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 07:00:51.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CbvDm4PJ53XJ45vcfyZH6oOH9QT6V/PlUUVlFChkA8s/X1FBfO7afYMoab+tmM7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgMTUgU2VwdGVtYmVyIDIwMjIgMTE6NTENCj4gVG86IG1zdEByZWRoYXQuY29tOyBqYXNvd2Fu
Z0ByZWRoYXQuY29tDQo+IENjOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT47IHNpLXdlaS5s
aXVAb3JhY2xlLmNvbTsgUGFyYXYgUGFuZGl0DQo+IDxwYXJhdkBudmlkaWEuY29tPjsgd3V6b25n
eW9uZ0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGVwZXJlem1hQHJl
ZGhhdC5jb207IGxpbmdzaGFuLnpodUBpbnRlbC5jb207IGdkYXdhckB4aWxpbnguY29tOw0KPiBs
dWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFuY2UuY29tDQo+IFN1YmplY3Q6IFtQQVRD
SCAyLzNdIHZkcGFfc2ltX25ldDogc3VwcG9ydCBmZWF0dXJlIHByb3Zpc2lvbmluZw0KPiANCj4g
VGhpcyBwYXRjaCBpbXBsZW1lbnRzIGZlYXR1cmVzIHByb3Zpc2lvbmluZyBmb3IgdmRwYV9zaW1f
bmV0Lg0KPiANCj4gMSkgdmFsaWRhdGluZyB0aGUgcHJvdmlzaW9uZWQgZmVhdHVyZXMgdG8gYmUg
YSBzdWJzZXQgb2YgdGhlIHBhcmVudA0KPiAgICBmZWF0dXJlcy4NCj4gMikgY2xlYXJpbmcgdGhl
IGZlYXR1cmVzIHRoYXQgaXMgbm90IHdhbnRlZCBieSB0aGUgIHVzZXJzcGFjZQ0KPiANCg0KUmV2
aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwgMTEgKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jDQo+IGIvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltX25ldC5jDQo+IGluZGV4IDg4NjQ0OWU4ODUwMi4uYTliYTAyYmUzNzhi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMNCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jDQo+IEBAIC0yNTQsNiAr
MjU0LDE0IEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9uZXRfZGV2X2FkZChzdHJ1Y3QNCj4gdmRwYV9t
Z210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwNCj4gIAlkZXZfYXR0ci53b3JrX2ZuID0g
dmRwYXNpbV9uZXRfd29yazsNCj4gIAlkZXZfYXR0ci5idWZmZXJfc2l6ZSA9IFBBR0VfU0laRTsN
Cj4gDQo+ICsJaWYgKGNvbmZpZy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJF
UykpIHsNCj4gKwkJaWYgKGNvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzICYNCj4gKwkJICAgIH5kZXZf
YXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMpDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJZGV2
X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzICY9DQo+ICsJCQkgY29uZmlnLT5kZXZpY2VfZmVhdHVy
ZXM7DQo+ICsJfQ0KPiArDQo+ICAJc2ltZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmRldl9hdHRyKTsN
Cj4gIAlpZiAoSVNfRVJSKHNpbWRldikpDQo+ICAJCXJldHVybiBQVFJfRVJSKHNpbWRldik7DQo+
IEBAIC0yOTQsNyArMzAyLDggQEAgc3RhdGljIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1nbXRfZGV2
ID0gew0KPiAgCS5pZF90YWJsZSA9IGlkX3RhYmxlLA0KPiAgCS5vcHMgPSAmdmRwYXNpbV9uZXRf
bWdtdGRldl9vcHMsDQo+ICAJLmNvbmZpZ19hdHRyX21hc2sgPSAoMSA8PCBWRFBBX0FUVFJfREVW
X05FVF9DRkdfTUFDQUREUiB8DQo+IC0JCQkgICAgIDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZH
X01UVSksDQo+ICsJCQkgICAgIDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSB8DQo+ICsJ
CSAgICAgICAgICAgICAxIDw8IFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpLA0KPiAgCS5tYXhfc3Vw
cG9ydGVkX3ZxcyA9IFZEUEFTSU1fTkVUX1ZRX05VTSwNCj4gIAkuc3VwcG9ydGVkX2ZlYXR1cmVz
ID0gVkRQQVNJTV9ORVRfRkVBVFVSRVMsDQo+ICB9Ow0KPiAtLQ0KPiAyLjI1LjENCg0K
