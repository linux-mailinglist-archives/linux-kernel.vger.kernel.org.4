Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0F6D0DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjC3Sky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjC3Skp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:40:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B2FF11;
        Thu, 30 Mar 2023 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680201631; x=1711737631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sCQIWGbEm5acbxcmF8qirOBmu2Zgj1Wg+gTe5g9pttE=;
  b=cj+rLUrdFbNAzpN8UA+b3CtoSDLFTAvxmZmgyAQZp+xreQpVTRdZe9wM
   2ow3B7tiBNqYF2SrQ2HEY9gU3kQ1+16ULNMxwAiM6KQ+D9qDt84DCy1Sn
   U1uZoMWqj4Pbc/tQ2sMc4QUzb6RtlppP60/JmBLMd7toZs8qGT/g6xaDO
   k9l+CYj6Dz8xCaCtIWPp5wiw4r+mPeWolXki3jBcdZKc0HIZNsIchfZVL
   razlo1Rq6zFoaUk6jWhNumXR12le+fveV45Urk1y/jbCTLR09r9cqva0k
   BiVKSEHTmUgPvpyvuw+CGNz8U0LMVMohlP//xYTZ6Xok0mMmFp2tDerN3
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,305,1673884800"; 
   d="scan'208";a="226735977"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 02:40:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrrScPNxj00njdSDOhkc/tqN36vmhpu3xKPXV334IrCYL6lJpSr7uH97K2MWmdSKcDT7gSg2GEaH/LXnk+/+bHU8mid6oJFsC7r58JIWcGru/nKEQ3CxfjAgp4Ny33fXxraCFh/phT6jl4nT8hfSzwObmGPG45QIL/AXYAJvkQbgPK/XOjB3YdXv4nsbgScA3GXTDqzd0hnLjXFHDWYRP/P76d+LslLcSYqJFXiqANsyslhWXPS+0ONw8XstZMjoE9iXbusLHqIAJzr0xav+KTM1romAiToNGg5lPt5rS5c3oudoiUO2gPLlGmQE3B/oTAPI6VWTnjX3ftxg29FE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCQIWGbEm5acbxcmF8qirOBmu2Zgj1Wg+gTe5g9pttE=;
 b=j/v3VXdfRy/uUIv62PG7NEu3JhkcsEom2SCBkuQEgzD7QujElgEHMlIoZEbCcYhTyp1Ft59E6qFrts21fd4MjT3uggsSUNGMmTPedWkigLgsccggzzGhsaUwnwWUqFj2uY8/1/s/rDnZSTpmeIthbzptT1tzh/iSS7x+TZV2V3S9p3+yq8H0+dGeI1BTbi79ELTK7FRcNz4TVByq7WYRKmtnp2ZPyOx88kfqvJuzqhR5SKjBWrvgBGs0nwkyQJY6XtX49eNJi8e0WDvCjNclOe1IsDmOT+dxsIjwNyQs7/84KXhwON4+VBvLo0wcUxh/t8B2L8Z60LFo87jUr8Ky4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCQIWGbEm5acbxcmF8qirOBmu2Zgj1Wg+gTe5g9pttE=;
 b=iw0n/bvdUyWdTzzM26F5ip6jKaG/IUBGduT35iGtxfnwJW3SNjelWZi4HgLtgrDt7IcK/3tHAOsM9mL5CcezpCRnpwSNrxFKNNGzaYilhlsLJUVUQRGM9GDg2e2It82JX0/m0K5PrDKNXG4HPC8C5sqgt2Qci0LxSvtUdzV33cc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6537.namprd04.prod.outlook.com (2603:10b6:610:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 18:39:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 18:39:17 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZYwkhPGeWI9qHCkmsk3QDzbHul68ThkuAgAAfJsA=
Date:   Thu, 30 Mar 2023 18:39:16 +0000
Message-ID: <DM6PR04MB6575FBF184F21EE63DA03338FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230330131109.5722-1-avri.altman@wdc.com>
 <8cb5216b-7dee-a924-1362-88b53ecbe6ea@acm.org>
In-Reply-To: <8cb5216b-7dee-a924-1362-88b53ecbe6ea@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6537:EE_
x-ms-office365-filtering-correlation-id: ed44038b-341e-4b99-1aa2-08db314e114b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRHqYcuXHLuWvGMuzYhFOoggDMIGUXwADqR5RIu11//BbYdeR43UaJXXTTIMt3R8dxd0h9uQ28QLtfFYHc0Rkm1EdW5V5rc+GczHyayP9W1ztJfT/zSFV9irjIf/RDFPG/7JxpCDy7nIJnUcKdQowdSC0oWTWF+MvlqJz1FMsgqDQLkiwB/taJU9yML8uRvb5zfmVw8h+ayZwyfJq0SBvS5pIPFblwCJFdO+PpSQ4LQZtd+IC2e4bqZxY9kJLNm44XY8U+lt7weYUDdXdc/nqagcMoLho4Vu4DGJOCDNNfjlw9CsUdAVYQwt+ADpjhnztY4DQh3I+/qNMEGcEofjcNYm97/8/WG0uicl7tYqOfnBcvVNjEnjuFjfsCbHSiepAUc7DqvupBSML80UYF93L0g4QMXqi0LJi2S/7JAT0tmufbEf0uuo2TlvbKSrZYDT7t9IQFQ+lAaPCJpXe8CXp+lPQDXEGh+jwyL7LocLYznCdhyRTNslDUOunYABnOZAp77mpcRNJPlNZHiwBMfZgspPErd8FE7/K6wTIakakzkpFkm8dCuxShfXV5wsamQwT4gxZot9hOEdVLXFH3IvQi6RTLFAqcMCkSgbzLOQZQVPBYZYaODlaIYO+74BVxXZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(38100700002)(33656002)(122000001)(5660300002)(38070700005)(8936002)(76116006)(4326008)(86362001)(66946007)(55016003)(66556008)(66476007)(52536014)(41300700001)(82960400001)(64756008)(8676002)(66446008)(54906003)(53546011)(83380400001)(9686003)(110136005)(2906002)(6506007)(26005)(478600001)(71200400001)(186003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNqdjRCNlNSakNyTDlCaFUwVzJwN3RlSG92NjdJWXJ0cklFb0hCZjNhUGE1?=
 =?utf-8?B?MWthYnRZUks2WFp6a0FUekVSRE42bVd6L3B4eTNiQkVrbDAwMHAvWWhqSStx?=
 =?utf-8?B?SkQvMldSL3FoODhvQTRZQ05ZbGJHYlVxMHBXZ2E5TGFkWUNWQVNwY2poUGtw?=
 =?utf-8?B?MzFwMit6KzhmdkRxWHR0YXFHa0J5NUxGRFhxSGVxUldDV2lVUzhpdVZ1SGpQ?=
 =?utf-8?B?L3dqd2g5UFpLTzI5THZzNlVnTHpORW1MUmRScFhjeVBZUzE3RjZNS1NZQ2cw?=
 =?utf-8?B?SGFyWkdqYnY3N2ZPdjNra3JvQXBRaGxWL2hRRkduZDJPcXBzMkJscmljeVlT?=
 =?utf-8?B?UVdIRE1udGQya0ZrNnBYYmdxTEVlanErVWFwMWp4RWkxUWcwbnc5NS9YSU1s?=
 =?utf-8?B?NmJRUW1ybG5tYmVaaUZNZVIrVGNjNkx2Z2pYWG55amloUGlDLzVPamNVNXVn?=
 =?utf-8?B?bXhWU1hjVEJ4dkVuS09KWnNpK3RUa2FtSTZ4YS9nMWZPOXpnZFNxWW9rbE1R?=
 =?utf-8?B?QURGT0FDZnBDNkh4UURqQyt0VlhiSHA1UXRpL2pjckNpekhOVUphOUdxMndU?=
 =?utf-8?B?RmJDOUxvbzBBQXBaZnduMkhBWkdBMmRid29PenpXbFR0WmpKb09HZ3I4a1FR?=
 =?utf-8?B?RDVPQlp2QWxOYTdNMzdWdlpJMUZXeFYxdmVYTGUvU3l1K0JVS2dvcWViYnJL?=
 =?utf-8?B?WGFEd21zSXZoTHlUZzBpamtaZ3RVMDBqVjBINUUrSHdKald5VjhhNHp0VHdC?=
 =?utf-8?B?U2FObFlFTW93TVNKaXIrRCtqZWIrR0ZBWUhRZlRwYlZhazJsUjhHWVA1eWhz?=
 =?utf-8?B?VUVOT2J0V09YKzU3SXhvUUNlM05oeU1wbTQ1SHhwNXg0ZFpZd2hEckFzWm02?=
 =?utf-8?B?S1IwN0s2eTdEdzVqV0FTOWF6NEoxV0pXbjJwYlo0ZFY4KzdJNW53aEEzTlF2?=
 =?utf-8?B?VDZPWGMzODdHWmJzSlNXeWZoc2VMeVZhdENOMVMyRkJsUnpEQXlPRXBNeDUr?=
 =?utf-8?B?Z0t5YXVnSllNejI0UDAzVWdKcTR2cXBoai9od2JSWHVNdzRGNUdxOG9zendB?=
 =?utf-8?B?MHpOVWdJUHc2Q3VGa21WcEdCSmxFU3lZSlVibmZkaWIrWFR1M1dWc3BFbnNx?=
 =?utf-8?B?blBJZEprWVUxNEJKbmlsQktoa1pyK2JXdUhQQVFzQVdPcVBBdzdCKzk0ZWJ1?=
 =?utf-8?B?aFBqaU5iMUt0QStDdStJbmtCOUpOcUdJMjdGVVIycUZkQ3NMeGRNQ2ZhaWVw?=
 =?utf-8?B?RWY4RklFR1JHb2VrMjVZaVd0V1F2azYxN3VHRTRYZUFYaW5BR0txTENWYWV5?=
 =?utf-8?B?UFFrNkJrMXJiUUNtNnRHQytRd3Z3TmhCZHplcE5OREVIZGtpMXZsRHlnYUdD?=
 =?utf-8?B?MEFISEh2YnRzVC90aDA1em82dk84eExZNGJMZE5Ra3BCM2IxN2dyUUx0RSs4?=
 =?utf-8?B?U2VrY0RBT1VhUFFxcFhkSDlzRXAwVFhtTU16eWlUb0dSWDA2OWtnN0VtQ1ZF?=
 =?utf-8?B?eXAyb2g4T2pOZnF4ckxtc1A0WlNDWk5iVHl6cmpVU1pwKzE4OU12dktVVDI0?=
 =?utf-8?B?REhPQkNkNEt6RVE0eXhVVHFNdVhIU3BYeWtMK1R1Yjd3OXNUUER2cnB2cG0w?=
 =?utf-8?B?UFI4TXB2aEtTVXFTVm9lWWo0NmVNQk4xcWV4Q2Y1bVlXb245TTJOdWp2NHF3?=
 =?utf-8?B?MmZRSFFHZHlDOW8rVnlDZnZyVTBwTmIrRTlTUXRZeUVMaDcxa2xxTHpuakJv?=
 =?utf-8?B?eXVEbFdGMmpRREFkS1JvOVk5d2ZFc3RIZW9vMFhsWHFKTW05cjllUldnVndy?=
 =?utf-8?B?R1FNUGp2NnVzZ0N4aGpnSitUQkhrdXdRRDE0cHJQakhDbXFON1l6NDJFM2ZF?=
 =?utf-8?B?Tys1amV4OXhSZ21FeXVIMXQzWnVMYjBxdUpuV201Q1VWNjNCSXJWQVZCUWUz?=
 =?utf-8?B?aW5teTVjRzVpQTNkbE1ERTVNKy8wSUVLZythaGtEQTFPd0l0bURyOVdKTzF2?=
 =?utf-8?B?RG9HY0NiQXpnOWM5dkRQRTgrZ2M1NzArdnRxU05aeWtONWhVb3dJM241b29P?=
 =?utf-8?B?NmZoR3kyOExDZnUyZFBDc2FtQ3l0SnRkNklTbXdMTXE2cVNUWG12aVR0YXc2?=
 =?utf-8?Q?dd5nxhK6aoiqGt2xfjgg2YEpz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i+dXy/OIw2SeVmX5PDAUnOgCFELRQzvFNg2mZdaVGRbB+KVP2V2PMp1JmMdAGka3aeKk3WkgkPrTGjf2KBwrRrATRyqFlMdeK5al9uQPe9VeGZSFekp2gNvuDQ8XtsXJR6ht4H8hNsLybJ/3HWFB4lY1hc0WOhOlu9oYOwXB744wjwgacBcUDESFjZ6oecZQitbBkNTOm0JgEZ65PIWRTikq8Z+4Aq4q+//HbwI3AW+K1Gwl5yK70rLSKZJbXbUpewaGg+1lK9K2VqyzUdmRCnlNDmA/X1Ve2RdcOmFv+ujgmsBYAVmOf9hb25c2mgkOyvW1hqaGZkq8kT69wLw2/B7tN0D1DsDUXP8zL8Yx2FwNIVCYGMq3ZUIU368rnDqWgFn998nXVn2BExc8iC1z7suxD+mKXvBao3jdUDb+5Okooi8N0bAaMEK5j0yI7PxBEFBfDimiLa/Bj85Wr6YHXhCKAOGmBGp9Q4ffDEJWyJxJHK2JRWnm7HUT0+/oayJophOuocRH+BZmYVjUwVgUCiBkB9nLwGgbo2TpUqRIpPpMG3OMPFUm3tL5b2gyT+MSb5NUigi0ODfL9V1hdEjrJbleCJAKbm1AtCDD9ZeWRU+yT4vrFjWcIGN9mvI+e5UrHy7xSTn+e1Of+uP7Z1Bcnh2rrNOuq/OGq0p2qcT8ET47ox4VF9/TaWEDRCFfXCyk6gIUSuOCuYkFqI9iX07X1NzV/MTBC7Dm2cCyr3e02Q/AHEI3JIK8rspnSyNJMSjFpn8IFFMR6VF2m997jjCKBxgQB55PNBuWIvQNf2QVqzMFTppb77cMOmTdymlMjfbqwLMRX7OSSiy612DYkgs4MMOajY6QKQm3A72noNhHeRUwATNR7tLWOJkveGizIVeZEjHnBBrRXneA34fTqs9xASU4qSNp9KQsAQ5UZZ7pAgI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed44038b-341e-4b99-1aa2-08db314e114b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 18:39:17.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmAeLLIu2xW5JHJ67uFW7RqV81eUiihwbOZBPyWQA1dMsb5iHEsd4BSZR9k/LPORwglQK9shj9O+hfE+bn6yMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6537
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiAzLzMwLzIzIDA2OjExLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMN
Cj4gPiBpbmRleCAzNWEzYmQ5NWM1ZTQuLmQ1MjljNDJhNjgyYSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4gKysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnNo
Y2QuYw0KPiA+IEBAIC04NDY4LDYgKzg0NjgsMTAgQEAgc3RhdGljIGludCB1ZnNoY2RfYWxsb2Nf
bWNxKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAg
ICAgICAgIGdvdG8gZXJyOw0KPiA+DQo+ID4gKyAgICAgaWYgKFdBUk5fT05DRShoYmEtPm51dHJz
ICogaGJhLT5ucl9od19xdWV1ZXMgPiAoMSA8PCAxNikgLSAxLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAidGhlcmUgY2FuIGJlIGF0IG1vc3QgMTw8MTYgaW5mbGlnaHQgcmVxdWVzdHNcbiIpKQ0K
PiA+ICsgICAgICAgICAgICAgZ290byBlcnI7DQo+ID4gKw0KPiA+ICAgICAgIC8qDQo+ID4gICAg
ICAgICogUHJldmlvdXNseSBhbGxvY2F0ZWQgbWVtb3J5IGZvciBudXRycyBtYXkgbm90IGJlIGVu
b3VnaCBpbiBNQ1ENCj4gbW9kZS4NCj4gPiAgICAgICAgKiBOdW1iZXIgb2Ygc3VwcG9ydGVkIHRh
Z3MgaW4gTUNRIG1vZGUgbWF5IGJlIGxhcmdlciB0aGFuIFNEQg0KPiBtb2RlLg0KPiANCj4gSGkg
QXZyaSwNCj4gDQo+IFdBUk4qKCkgc2hvdWxkIG9ubHkgYmUgdXNlZCB0byByZXBvcnQga2VybmVs
IGJ1Z3MuIGhiYS0+bnV0cnMgKg0KPiBoYmEtPm5yX2h3X3F1ZXVlcyBiZWluZyB0b28gbGFyZ2Ug
aXMgbm90IGEga2VybmVsIGJ1ZyBidXQgYQ0KPiBjb25maWd1cmF0aW9uIGlzc3VlLg0KV2lsbCBy
ZXBsYWNlIHdpdGggYW4gYXBwcm9wcmlhdGUgZGV2X2luZm8gYW5kIGEgY2xhcmlmeWluZyBjb21t
ZW50Lg0KDQo+IA0KPiBJbnN0ZWFkIG9mIGZhaWxpbmcgTUNRIGFsbG9jYXRpb24sIHNob3VsZG4n
dA0KPiB1ZnNoY2RfbWNxX2RlY2lkZV9xdWV1ZV9kZXB0aCgpIGJlIG1vZGlmaWVkIHN1Y2ggdGhh
dCBpdCByZXN0cmljdHMNCj4gaGJhLT5udXRycyB0byBhIHZhbHVlIHRoYXQgY2FuIGJlIHN1cHBv
cnRlZD8NClRoZSBkcml2ZXIncyBjYXBhY2l0eSBpcyB0aGUgcHJvZHVjdCBvZiAgaGJhLT5udXRy
cyAqIGhiYS0+bnJfaHdfcXVldWVzLA0KV2hlcmUgdGhlIGxhdHRlciBpcyBiZWluZyBlc3RhYmxp
c2hlZCBvbmx5IGxhdGVyIGluIHVmc2hjZF9tY3FfaW5pdC4NCg0KVGhhbmtzLA0KQXZyaQ0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCg==
