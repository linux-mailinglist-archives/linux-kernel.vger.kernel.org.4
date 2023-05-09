Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F116FCB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjEIQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEIQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:19:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D62113;
        Tue,  9 May 2023 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683649196; x=1715185196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jgTVLG3DzbOMtfXvhLPKMbuezeSuv6ytD0uhJuwIXVk=;
  b=jqdRjRfNUPuSiAb4xNqTZAljTi6ZKB0Bahx+lMtO69S/esNIk+kMbush
   4sSmWjL4l7XR4F/huzfRk6tiX6b1Av9nOlU/Ab4LTm59P41C89Oiz0TWI
   KcqYzh7jq3Hb7i4OWl5ZVouYNJv0FzUASTE8zSbbaS64+BogiKD5myqyK
   rnp2DpdcfkNit1fHr2BDbHREiuWfCAMhlPDlBgpPK1WhdgQ1/5UtnDyRB
   7bvYCAleQzh2Ixn2G0tLbjSbSK2kmKNvQW1aRr41XNNAE8HQhk3UuiE+a
   CtMqAodf8ARufH6g2Z5rx1BdTvKlsQO9B6QvUR8IoftiHR8GI4jY9Lx12
   g==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="230278185"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 00:19:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcwJDamsLdOIYWkKTaIyXmZj0sPQ1R3Hwxsa7WfJErIgF+1cIlqxT737b+XoJx6Z+/hDJ1gYdkZ7zoRWcZcO1s2m9iCLeuZWPG7T2BkNcp/Eq9d9uGaAQV+Uu+gsX+rlDo9E0Fqag+70FOSH+gIEpWWxKa4FyjRcMVcJ4UWqjcCWdsbkX5QYZ5wxiPG+UA/2qjjcWcF0bc57ufX97XNziFL+/ZkJIfknPIDKdsp9kbaIXhAgetKx68xawnuvQFuLmbCxb3dsysMXVTvo3wDSQ5A9Gi1GU2O+BA0YqYvNUNwxHoxJr3+Mjtt9G+P9X2iEhpGMlHyn7RkmSj2wYNUu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgTVLG3DzbOMtfXvhLPKMbuezeSuv6ytD0uhJuwIXVk=;
 b=hyL9Cn78cAYR6DKNkFSSUyIVazHSzmjysBE8jVaTV/mOgYLUmIElfa3IxKhSPCxChah9Uc7N0Ee18wkzPY9jT3LMXd9S45IKlN87XgY3z2zPQ2gdfr8dpbhbNODPT/GVvKESuVQ6/gg21yBDnUSo0CNaJXN8LvbYOhFzEkTgyoXjWKJoBtFG+xXCh5BQUTVa6HZLKTpYg+s2af5f+ginYM/ykuZgONHC0M7gX7B7snf1Z6vt/gBqveVDucHKpSXVeYv87khthX9Juq7HQMTc2rkkV4sfRcOGbblpRSIOPo1tqZdWlZ6MiSP1nmnfW6CEHLb+5gC2kyXaD8HW0GPfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgTVLG3DzbOMtfXvhLPKMbuezeSuv6ytD0uhJuwIXVk=;
 b=Ap1Yq/TxXXcaxA5FVGymPdgoEP6OM9KrhcL/TyWNPVAxEU3cbyiS7DDkqeaSbrMeYOMT6fk5UKsioaz8wcgVPa7MOgwVSLzsElHqcLzi9luLTDB/cRlEZAJ/jkt17CaQLrWk6j0NMoGsSv+TLBkNwK/hbyuY9L4kGUwIBdl8Aw0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6796.namprd04.prod.outlook.com (2603:10b6:5:22b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 16:19:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 16:19:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ed Tsai <ed.tsai@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "alice.chao@mediatek.com" <alice.chao@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "naomi.chu@mediatek.com" <naomi.chu@mediatek.com>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Topic: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Index: AQHZgkMMEfz/mkmxPE2tTXnep9Miz69RlGFwgABlVACAACPsMA==
Date:   Tue, 9 May 2023 16:19:52 +0000
Message-ID: <DM6PR04MB6575F344EF2D962103888A56FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <DM6PR04MB6575753742F933DE192E7325FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dcfae203-005f-928b-37d6-7ee5bb4e2971@acm.org>
In-Reply-To: <dcfae203-005f-928b-37d6-7ee5bb4e2971@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6796:EE_
x-ms-office365-filtering-correlation-id: 58de8eac-6bdc-4ad2-e35f-08db50a93833
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDUlR0Ll7dxIH3PtCuyz1vAjpQ2f6u7/UlmPz/xSr0/buKCgR5NFy2vWd6eQfqIzadxmHMHUXjy6pwawWy6w3oD5NPXZ6dq0PmpvStvJmPVmUmHkldpbJu331Tq07ofCLZPVLYLXuLhLOM0/SAavMkalTqWLCNLigG78icrEnP40Le2USagLhGY9TAxLYZEj8ws8j+6CEegZ/Knk04NbxksskF+hwvtxEyj/y4bO/1/Eg+Qn6daY0jEIkBKBrajOy/EoJCbyenuCG4qKCpkPdedhcKTW8/MIrvfA1v//WrCK5wf9OpwSpjv3Fdo0WSfghh2EoVPeOPNJUeqzwPa6sjqeE1CvdNKut+fOfIsmL0lmlBrML/idf3GaoSnQv62/rAyMxoFUCAFjhRXRrucrBqtSvmXVTXvF5YkpsdMnoZv0cYpCtyRnOFKTQCTmRogvxSEXQ10OuOgzSNVq/xDpuxW5Dh+b+4rsdYvGpbYLpxecZmDjITLrSwMXV3dVXUab0MNHt5MF5/EmwsAEEPuJenSCKi+6x61sbddF3Pzz8NM9+c3vlz79vBYUzN1KrW1YqX7DNSZGpF1BCwP1lv7uvNiNO6R2Zic31N9t9trHR0MQ39JNfcBqEPeIyktYKPCR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(478600001)(7696005)(55016003)(82960400001)(41300700001)(38100700002)(66476007)(9686003)(54906003)(53546011)(71200400001)(6506007)(66946007)(110136005)(122000001)(66556008)(64756008)(66446008)(86362001)(26005)(4326008)(52536014)(38070700005)(5660300002)(316002)(7416002)(76116006)(8676002)(8936002)(33656002)(186003)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RHMEFHSHRWS3ZLMXRiZkcrRFFWRU1ncW9QcVAyV1ZVUEtaRTJIWWJHZm4x?=
 =?utf-8?B?VklKSWNGTXJEN28zcU1TZkpTMnYzci9JMll2cCtKSm9qMzE5NlRZeXBVakFU?=
 =?utf-8?B?ME9ielJ4Mjdtck5pWkJVdm85a21QOHFZWDE1R3lXNndQVE9SUDJvU3h0VUdG?=
 =?utf-8?B?SEV1Ym4xVXNvWnAxaERSaTdUUUl3MWx5VG5FbWY3QTFpSVlvdnFKUXFJeUUw?=
 =?utf-8?B?dWZSMEtIbWgrQUZIMjVKSUxLYUoxdnUyaHJwNzh4YkRDS25NcHYvVVpzcis3?=
 =?utf-8?B?WEtsS0hjUHEwWGdVMkFlNTJSRk4wdmJSanBLVE1Sb1dCQkVLV0czT2phYjU4?=
 =?utf-8?B?VjEwdWN5L3pMU2oyLzNlSVlTQmJEbStYWmpBbGVKb1IxVU9jQkZsbnl0M3Ni?=
 =?utf-8?B?dk0vM2pXcVNQNFhSWjNsenZ2NHdYTHhJK1dvdzVpelozTWxCaGkwUUZ4ak5l?=
 =?utf-8?B?RktpSXZJS2kyZXozUUptQjdCOFJ4T0NYUEM1Q1NrRnB6K1JHeUZHaHo3SFFm?=
 =?utf-8?B?d3o3dnNSaDF2MllvYWJ3WjdTZFBpb2N4M3FCQ1BNNXdERitjTDJGN2xhWGs1?=
 =?utf-8?B?VFFZaUtaQ2lqb3RMLzdobFNnakRmOS9VRkRwemNPTTBjZXM1ZU1wZEZudzRP?=
 =?utf-8?B?VTFFbjNnU0tyRE15dmdjOHBLWDBYc2pUaWlkNEZFTGNlNzdLV3pNdkxnR3BZ?=
 =?utf-8?B?Tkp2MU9NWmlSZGJyNWYvQ1NkaE5NWFJIM0ZRYnU3MUlQZVN6bDVsdG1QQXNj?=
 =?utf-8?B?eEYxelBGYWxNS2xzK2xUcmMvZEY0RmFLVmVBOTRPYWU5L3dtUUtPS0lNYlZv?=
 =?utf-8?B?anZMbkd1ZFRWc3RpaUxOZDROUU5vM292S3ZmSCtpTTN5QTJCQ21teEVBK3JC?=
 =?utf-8?B?WlRwZkR4K2hnU1Uwa01Zc3lnQlI5WFl6ZSs2MzRuVDlxQmZLVGlpU0ZWaEVz?=
 =?utf-8?B?NCtKZ2dxN2lvVitDa2JLbXhESWk4S2QvKzl6aTlJNG1pODkweTFNVDh0TmQx?=
 =?utf-8?B?eGQ3aEhWcnl2bENkTjhCVUZZOTIxd05wc3lVMEVXVFZZS1lYMnNnREpBZ2Nr?=
 =?utf-8?B?NlZGOWU0SHQ0WDljTXdjVjVoRDA0Q2VQa0pNMDBoTHE3MzRzdGVGNWFZNkd4?=
 =?utf-8?B?RXhnNnpLTUlITlEyVkhNUSszQVArQk1sZEkxRVBudUhWZU1QSHRDMk5rd0hl?=
 =?utf-8?B?VFdtZGhPMEhxVUdjSVJoOWdpVEFoYXdBZVJrTXY0R3RNWXQ5Vlh2WmcyUE5p?=
 =?utf-8?B?eVkvd3krME11Y1g0UXRYa1V1RlN2TEZSYUNVVUxwSVNhTWNMbjUyQVRMb3Az?=
 =?utf-8?B?WGRyS2JneTV4TytsVlhuMDljNi9TS2xNcXdPaitEN2hPWjk4VTIzbGxnYitV?=
 =?utf-8?B?ZTFJdXEzeEc0UmdkdGRJK2czczUxRisrU0ZJYkI5SDdWelBtcG0rZnJRV2ln?=
 =?utf-8?B?VHlEWXIrMDFCek1oM2hYbVJUOHBpRVJGTkczc04vRU00Y2VxNTQvWHFhK2xB?=
 =?utf-8?B?bGNvYytYQjVSNlZ5VkRObEVlMW1TUFN1dXZ2VzJZTmlqS0dTaWNKdjdJYjdE?=
 =?utf-8?B?YnhLSkZ6cm1wcVBEcThwd1pQQWhQZ21Xc1c0Ry82RFNMcmNlSUNXNVRuWE1h?=
 =?utf-8?B?M2Nmem55c252WmY4NzBLTytMNTZtaHpGaExRQUI1YmN6MXorWHNpZWNMQjhx?=
 =?utf-8?B?SzdReDl4UkgwNHhxQzdjZnN5TlVzb3ZoV1ljbytjS1QwbmgzOXBoUHpTbnl4?=
 =?utf-8?B?dmxOVURDT2VWdjMxYnBvOSs0Q2dNR0dIcjBaSHo5blhOSW1oSFhqNURlV3Qr?=
 =?utf-8?B?Z1BtZnpBcGpHT2NremsydStxWDE3TmV1ZGVlZ2ZvNkZFU0RQRE43SUFzak5z?=
 =?utf-8?B?QVJlNjhqUEc1WXhQWUVrZjlFMjE2QnZtc0x5NVdLenFWMjBVSFhDZXkrZGor?=
 =?utf-8?B?cU9Fd09PQmszNGQwcERLMFhtU1ZkL0srRFFqem0xZEwrLy91R21iU0dWYUNF?=
 =?utf-8?B?QzdvUDQ0SVRnNlY3dEdyUkVhUEhRejlxS25JZVNlaHFOa3RNMWVDQ3g4ZFd6?=
 =?utf-8?B?WmhBWCt6cVhLSW44Sm1TaGxpNVpPV2pBdWR4NTE0RUp0b3BGTERpV1IvajRZ?=
 =?utf-8?Q?yeVekv5MHSKkLqfhmnjIn/a6I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ngJlAOLFMWy+hLSRnuQN8ifuQKLjC3v77YxyKcS8tU7xOy8AenhJfzDbzemGG8wLBeak8MkjzQybhWRKO3rO+TJX0lNT69F6PUfplldpcmIKgs2kWvbGmEhTfiZ4mNebIeiWIRsyc9T+h2mx39e0k9lDx6eyNcphhnHINGJA5H+omuUtPW8qZksQJH/p5iD5mCFigAyNFROJcnLVP1sN79efRMx7MRF0iNGEbeCTmqzBFLPuhUMe8IRpzLCPsYbWV9h+e9xcrjM/QNmidWu3EHpWiI5ZQbAwLT4z1VwDSVXvdMCx4K9wjnJu8vETgKRU1Q6IgVTZ/drC65zvbVmdlxT6DibJdMBf8PYIuy6ZATKplFPJvILTs2Z9WwbjWEYfFS40I4fCgj4t7Ash74unXGb9FOV7ZimgsYJYrcwCUfJotvpMEVtAmEp3QvY81kklJComirqfJOyaSpBLUtcTn0Tj1IfTL9ZDZrZhrW+Lj4h7dbn42LGISO19TtRo71gqUZuYJjMZXwUfB6yha1l8SLviMtX9i7af6YM3NRN64MVesdyC+K6vHCtTSf015FlURb5psAOCKMzGmqzSkJm/9zQbE5LiPIKEOU+NZVmC9hgER4rq0j+egQmSSUv9uPCTgUIqig/Wy8Vvspt0Os6e9cXtf59RAG7jIiBwlZoIkOo/hpSwKeNtrG+/LHh4FXvBkwpI35ynQOvvg0XrE+Ogo+01rsGKyF68VBglhGffDV0gcPFFL+Wyg+Uq7eqNoUqDUSKwDTPvAMtjhl6/8/Ir8Lam/U+4yWpx7MSSg62Q17oHMEwYLMLTYorM0pNAtYJqHfuelc98hpqVSAdCvqTJGOMTIWj03akOhCWY3cuPGI4PsNwqd7wyXyk4NyAE0xM3zOtY11honAveDeNHx1G0Xg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de8eac-6bdc-4ad2-e35f-08db50a93833
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 16:19:52.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfULebtH13GIgKvhNahBiAhjp0ztmKvv6R+agAeOJcINwZORfLEuACXGqUu/GgBliUBPNiVzHXQkxKIiokarAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6796
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA1LzkvMjMgMDE6MDMsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IEhvd2V2ZXIsIEkgdGhp
bmsgdGhlIGRlY2lzaW9uIG9mIHRoYXQgc2hvdWxkIGJlIG9mIHRoZSBwbGF0Zm9ybSBvd25lciwN
Cj4gPiBBbmQgbm90IGluIHRoZSBjb3JlIGRyaXZlci4NCj4gDQo+IEhpIEF2cmksDQo+IA0KPiBJ
IGRvbid0IHNlZSBhbnkgdXNlIGNhc2UgaW4gd2hpY2ggcGVyZm9ybWFuY2Ugb2YgYSBVRlMgZGV2
aWNlIHdvdWxkIGJlDQo+IGltcHJvdmVkDQo+IGJ5IGxlYXZpbmcgUVVFVUVfRkxBR19GQUlSX1RB
R19TSEFSSU5HIGVuYWJsZWQuIEFyZSB5b3UgcGVyaGFwcyBhd2FyZQ0KPiBvZiBzdWNoIGENCj4g
dXNlIGNhc2U/DQpGb2xsb3dpbmcgeW91ciBhcmd1bWVudCwgdGhlbiB3aHkgZmFpciBhbGxvY2F0
aW9uIGV4aXN0cyBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNCldoZW4gcnVubmluZyBiZW5jaG1hcmtz
IEkgYW0gaGFja2luZyB0aGUgc2NoZWR1bGVyJ3MgImZhaXIiIHRhZyBhbGxvY2F0aW9uIGFzIHdl
bGwuDQpUaGF0J3Mgd2h5IEkgYWNrZWQgdGhpcyBjaGFuZ2UuDQoNClNpbmNlIHRoaXMgY2hhbmdl
IG1heSBhZmZlY3QgdGhlIElPIHByb2ZpbGUgYXMgYSB3aG9sZSwNCkkgdGhpbmsgdGhlIHBsYXRm
b3JtIG93bmVycyBzaG91bGQgaGF2ZSB0aGUgZmxleGliaWxpdHkgbm90IHRvIHVzZSBpdCwNClNo
b3VsZCB0aGV5IGNob29zZSB0by4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gQmFydC4NCg==
