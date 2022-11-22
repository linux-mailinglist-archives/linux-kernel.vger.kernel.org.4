Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F466338D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiKVJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiKVJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:42:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DD4FFAD;
        Tue, 22 Nov 2022 01:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669110119; x=1700646119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ck7ws39l8LrPefe4T+EapqCwPuTZ9VXnyXyYeI9AlaA=;
  b=m02MNFgYFKuGFNiay3KnihsQ+iduhkTPU4fAp21BjHgjKLc0vdls9+w0
   Z64RqWBhdYapM5Qmno7UcGXadKJK5gpd8cksG2ln86DGp6Bqjv9CIBM1l
   M8g/yiOLIqD10egU/3N+u6jU3gWl/Ixmvmv3Jzzx5gTiIX74UY0JjaPqW
   /sn2Lui6TSA0LJdQzGp387tUS9pZoGI/Y/wbJmzRoN2cWO7ydNHbReimt
   qLACg3WNUN7EWtT+UZ/wa+8wRqYkIqi30BFkMjcgJbNHkzxWmFFn1nTFB
   KcunX4NC7n4Z6RjNalT7R3I41n2anw6IGqCAzF+qr2pNUarkSA6tmr0L2
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="217185222"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 17:41:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPRpmABPCK497WOTdc2q1g4I5rSPh+A1X6TuRMQX+R0OXiKusJ0LIcRGSMrKZ7qqQiwAt6vBo1xwkxGfxBtiZnJBLuwPRNEo5luG1YIpQ85+rlF/dBczmlZBFcvY6UghE0HIC5r+p+Tj3DktCohGnPILMsmDej4iSBKYDC9vGScnHJ+JsAaESsiGmOu+BgDNw2O2HYIZ6bPu2DbgYLEzB16WTMK5yWIle3qJ+fnHwMVh7Vr+1h0sMJrYctXJsWtf3BhDHm5qgDDs4Kv1ZMdecKLqtvxkpKDfOd+/NAAE22dLPnDe5yxU48ejSVOAM/pxNzB66dYA3HUu9rUjjPsi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck7ws39l8LrPefe4T+EapqCwPuTZ9VXnyXyYeI9AlaA=;
 b=fYNpB5tO6eYVvSBf2PbxUpEqXSuaZZyLe4HQn2aESFQ4AWCxWdHah8NnvSmL30LlfLNpPW7NvoWQ/2O2dBfDrYPyD05rwAMQh/raZLADPtMVjPCP/grHV41XmnsrRTlfx/LVz352Zw1F90Gqv4Zbiw4BoO74w89slUwJ0LbRVeg6QNpn3v6EArQV5SaPCS0pW90eU7/f5ahJjuPUXRQbxnE/bygUlYKD71C4cIPWYFaaUfuMvKeZjga8lQyg4cY0VX7XcTcVH8TaLf2Ml8kXYUqdFJllP+MCOnTa4zEp3R3/mn/CVH006wotzQzhTOeFosOkM2fOyuRbCuFZZFxIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck7ws39l8LrPefe4T+EapqCwPuTZ9VXnyXyYeI9AlaA=;
 b=olSEoDKAsIFqtegrf6lFvRx58VefU43si4erGgYvTpFPqtIENMVbFCRlia6KmtR2pEpQf62ZJYYRTC9RxSAySJy5d+gKZCR6g+K+Q+ecSzMs7mSHxhHm/6BfuROPndg4bgebpzMk53FU0GD0RNvgSknNOZF7ga1taeWGwSvBiEE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB8104.namprd04.prod.outlook.com (2603:10b6:8::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 09:41:56 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:41:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] ufs: core: Pass EHS length into
 ufshcd_prepare_req_desc_hdr()
Thread-Topic: [PATCH v2 5/6] ufs: core: Pass EHS length into
 ufshcd_prepare_req_desc_hdr()
Thread-Index: AQHY/S6fl5HOD6drnEeHW/KusPmMb65KsssQ
Date:   Tue, 22 Nov 2022 09:41:56 +0000
Message-ID: <DM6PR04MB65753370033655CA4A7B1EDFFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-6-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-6-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB8104:EE_
x-ms-office365-filtering-correlation-id: 227b4435-ea6e-4f36-edd2-08dacc6dcb8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/q4Q2p9nBWhRcLdZ4nX31sW7QLndVfwMpT21kNhc8EI+mIjURgTBbivmE/aK/DW6zDVAjDrcN3uKp31NIIZhg5uiBtzs3l/L2LtuYQrr8FMbpJ9Jg7byZwzuCIwhcPAtqCmYXjziRHQF7XDUHQsOCaANWBcdOQ/iFxc4xFKJKKtxSaWirsnlJA72CezqAmanXTnmjlaI//BrSmL36Nbk0MqfdzmSxMH33Z7Qkhp8FtiWXaIXoO/oLjfAwThva5UCZghMULpjsBF7TVjtrFihuMWSM39c0bwYfe9yrGdH4g7Y0XMXjE80v3iodXKr+/J2u+k/TjRo9eKpaZ0sMOP6ipwacaOtZubMPorfTiAUZBftqNQZyDxSGIyhNe7eK8u4Qcc0sinoKeKlQfATLzUCe5uyC+ynjmQIYQ/jndvNTaZrf9LHX56l8ehmnz3bQuLjJiu7SnQk1+gPailPXAdlQmOOp+pRluSl1eXjD41b3seSjLBwoUxoPUf4N9mrhW9HNl4S/4k+PfzhuXWUanIwIMlYTJ1WMFRsA6UmB/PyEAaAvhQ0G63QHhbWeX0GZU/B869jroJt92FtcXjfWRjf2ylHuXCN0E462l261/nI2b7z2C2jpANeX/ZPBvTMNAdB8Oftv23cQKHXCFqHS98IcRBICJtj720fjewz8cWzrT8bMHaddXt4u2lTQAig42ZLkSjALcPJOhEi5h9w//hGjYCnoOWjnPVte1UUik81bxubGRUQ0qZGnzN8PLeKLBwtqhJqHpkNZ8ZokYyJco8Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(33656002)(86362001)(38070700005)(64756008)(7696005)(76116006)(55016003)(7416002)(5660300002)(26005)(38100700002)(2906002)(186003)(9686003)(83380400001)(122000001)(82960400001)(921005)(54906003)(66556008)(71200400001)(6506007)(52536014)(8936002)(4326008)(41300700001)(66476007)(66446008)(110136005)(478600001)(8676002)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDE0SVBSNEc1S0NBU05kZnRXVmQ3UXhZNWd0MkZVUmdlK2V1ZG5lM24xTExs?=
 =?utf-8?B?Sm5ISDBsSmU0VXdsLzRSSGpVT0IxYXFORnN1d3dNQW5GcTNPWnJvRGpxQ2R1?=
 =?utf-8?B?ek1WcDhIRFEybWZ6a1QyaHgwb0JHa1hoSE5YWEFhR3NyWERVZnVTVjhNd2Nz?=
 =?utf-8?B?RFBXS0pBMXllWU5DRW9Nazc5cUpnVEZYTi95ODRxZmtCSWpDV2tzSjFlSkl4?=
 =?utf-8?B?YUh3TWlvNDJzcVVzQ3hEQ210M0RZbGI5Z052aEcwL21uM1VwV1ZwZEhrdFpr?=
 =?utf-8?B?MHhYVWhWVUtFMHR0dWdCbVIwK2dhbHJIS3NleUNLcVZGSlFpMXJieVdUVCtt?=
 =?utf-8?B?Y1pOWk9mTVZlOW1HaXcyRjh4dlpTakdsVTdDenU3YjRKU29XaEZDVEFJc1lk?=
 =?utf-8?B?cFU3cGc1U0t6Z0pzSXZMWXlVZjdqZGczQVJvZkxrWk15T090UDRxaDh5YVVa?=
 =?utf-8?B?V2pKRllqOG9EY3MxRVBPVDR4S3pPc3hwdnJOc2M0Z2w4SjAwQklwbUtwZ2Vw?=
 =?utf-8?B?RmxCcWxqSDFYKzhGRmJQSGgyek96RStoeGZGbENvZHk1bG5kOHN4VzloSXBI?=
 =?utf-8?B?R3J2eXBrV0VFMHdGZlROY0ZnSUZzUWh0SVkrMjBDVmY5aDl5R0txTDVJN2Vv?=
 =?utf-8?B?Um8zUUdPWWxWanZaRDh5RjZLazZ1Q2tBekRGRXZ4ZmswZEJyaFFxVFZxOFUz?=
 =?utf-8?B?Wks2Y25pQW9VSzdpZEFtdW1wMVZvZGhYd21PZEcrdHloZzExZ2s0OVVQSHJa?=
 =?utf-8?B?VzN1QnhOWDZjc3BuZ3JNWjMzekswUmp3eE5VMGpsR2VHTHB1TE1DajVaMEVH?=
 =?utf-8?B?WElwbHU5NndOR2tHVHhoN2tZdkV4MlpuanpNSXp2SXdEazlBYWh6TFV6N3lR?=
 =?utf-8?B?d1NxZ0JPRUNvMVlxdkJ0RDlvTmYrNUtSU29UZVdvdmpORWJXSmJzeGVJd2JK?=
 =?utf-8?B?TDQxMXJDMUNubDNaT1U2Tjc5S0JKTExEeEtGTS9Balc3U3RkaVl1eWJsWURR?=
 =?utf-8?B?TVhtNlQ4TVh2aG5sNkJ5OUpWditIRTA3QkduYlpBTWYwdWsydHRHRi9ncU44?=
 =?utf-8?B?RWwybk1ZK1E0RWxsUUN3WVZUSnUyc091aE1IdGNTTGJxcDFURTdlOWQ3L3Zw?=
 =?utf-8?B?SEVwZCtGMlp2YmN2Z1dzTjU0dStFL1psVWRzazVjaGVINFUwYmx3M3BHMnV5?=
 =?utf-8?B?a3lOZHV2SEJnU0JONHBGYVI0eFA3WGwwN2JlQnltVkpZY1Q4MEYyQVJPZDgy?=
 =?utf-8?B?ZnM0M1VyUkpHcEREbHlvb29IR2Znajk5cFJxQS9XZzdNaVpuaC8vb1JHcHZH?=
 =?utf-8?B?WUMzWXB3TUtjV3pnK0hjamwvaTcxUVhpazd0ZUQ2NUJERk9XWDJ0VDBIeUtC?=
 =?utf-8?B?alhEU2ltVjZueWFJdDZYRzI1UEZRdDhZbHJtRDBoWEY2MDhIamRhR1Q3eUp1?=
 =?utf-8?B?NExkK3dqK244dzUxZ29sRnh4WGxxVlRPQWxVaWwweGdOZHBZbC9zMG8vbVVV?=
 =?utf-8?B?QkxHR1JIODJZb0xKU0hJL2psaDFuMXcvUmp0cFhkUXZzSXlnOS9UZlRzbTF3?=
 =?utf-8?B?dDI4R2JXY1FGM0s5TVpxVzRGWW1UWUNsZVZNWkVXWDVQUGhYSUZ5RERMS29w?=
 =?utf-8?B?ekxsVHFrZ3ppcm5oNmx1NVl3OEVucVE1NkdsWGg2SWJaa1JrT1p3SVFnTDFF?=
 =?utf-8?B?N01Gb05zRlFZbUZZY2FxN2l0Ty9LRm1COTZ6cnpTVUNyZ2dyNUFWRlBscFlv?=
 =?utf-8?B?NW5STkhaZlZQRlRmcGMwcDUxS2lkU3RaUG50dU1BVGo3Qml5dExsemNwV05C?=
 =?utf-8?B?dEdFVUJMYzJFNFh4UUxyK1ZKQzJCODJncGhTR0pQNzZHR2JWd3hvdFVOZDZI?=
 =?utf-8?B?TmFKSjlNN2doNUh6Uk4xRHo0K3Ywc29BUy91NGVQejdISVI5QmYxVFVMcHhK?=
 =?utf-8?B?aGdIYTRSeFlIR3VyNGZkWWFJcFk0Z0lEU3NOdWs4eUI0eXFMNnpWSWdCYkR1?=
 =?utf-8?B?RzRLSWRGb3ViNTdtUUlZUzRlTGE4dlZNd05UVlNFRDdEaUFzKy9XRFE1RmxG?=
 =?utf-8?B?SHNYUFQ3S0xwWHpvVDhBaFBlMEh2bnA4ZWJ2dzZucGU3M056K1BFbFlBSlVS?=
 =?utf-8?Q?7w6exRm1IVyP8Cb2TlFADs9M8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlQwVloxR2hiNXRxWDNGb3pwZVV3dksxc2hQN3F3N1JjKzgwWFZHK2FvWkt3?=
 =?utf-8?B?aFpVYURoT2wxRDMwYytLTmcrOHVUVFdvZUE5QzNDOU92M2trYVFRQkFNUmRk?=
 =?utf-8?B?MmVIYWlINkZuTUdUMzMySkMrcmxuK01YV1d1NEFZQ09lL0hRcVd5aWZLRzZJ?=
 =?utf-8?B?UzBDNE1PV0MxRXRlUlM5VnQxSzJxYWJzZWo1cVNxSEYrSkRZQ2hTUXhsWGZk?=
 =?utf-8?B?SzlGSzBIalh0a21EOHR4MlZDUkRJcWNTSEFBaVRWVUV1VVN6aVpEanVWSFJl?=
 =?utf-8?B?enB3VDExT3ZidG1vS084SEc2Vmh3dHdkUDRVQ0JVKytGZ3Y5anhaR3R6R1pS?=
 =?utf-8?B?Slg4SUxzdEtrc3dycVljNHNuRGNvNGlid1BLR21EbFk3YzhrR045SmY3RjN1?=
 =?utf-8?B?eVV1SWNhaXBoUjZOd3pQbXZ6aWlBUW1nZUZZcSsxU2QyZ0xRNTEzVnJ4VlBx?=
 =?utf-8?B?TUhRQzlyQVo4cVdFbUY0N0RVaGt2eGpyQzNGNjFtaHloSzdoR2FWSzQvNjEx?=
 =?utf-8?B?bVNjK3VKMnlOeDJaRGo0UE9RZmNaT25rUzZyM1ZqYTNKNDZXN2d6V000OEt2?=
 =?utf-8?B?VERIZVVKWkRibFdXQXY1aEFPK2dPU3RIaVFOZklLRGswT2ZOVmxPV3NONjc4?=
 =?utf-8?B?bkY5TmZ4TjhFeWMxWjAzZkE1eVBicTNhMldQS2hkSTFxQkpWUTdFd1MzSGdO?=
 =?utf-8?B?cE9wVU0vS0s1eXVaSjZWQjJHcys4djhUbHFscG04UGJHRkVmc01xQ3VBMktF?=
 =?utf-8?B?OUwweFpwY3I1OUJ4clJDbFZvczVWaXpHdDdNd091YWdsZkUxL1Nhb0ptSWx3?=
 =?utf-8?B?R3lObVdQd0EvS0tmK0hPaEpWTXJndklneDhzOU5VaEtrcDdwSFBCeURXNnpq?=
 =?utf-8?B?WGRweDZUWEFNcndVd1lyL2tWTWxSaTNCMWVFL2E2cTA0TitvTEg2RHhoVFRU?=
 =?utf-8?B?eFhtaERkRnNEQ3NQVkt5K05KUVZ1WEU5N3lyeWJvRDJVZTVCdlFpYlBvd1l0?=
 =?utf-8?B?K2xNdHJMQnlDamwyamNNRlphK1p5RVNabE5Cd1pvcSs5M2Y2MmRuNTVDNDJX?=
 =?utf-8?B?NjQ1UEdlenF0SGUxUVdHMHRKOHpaTFNKVXQ2UTd0REFIeW5uZEthTG5JSFJG?=
 =?utf-8?B?WDNvdk1mMGt3ejgwMmRwQmVZdlIydExjaGJEQkNMbFZjTjNLUS9KbzlHYkNw?=
 =?utf-8?B?WFcyTzFDR0swRWZEdzd0ZzNMRFRwekVZVVN2TUlxOVZHU3ZpcndaWFZiYitj?=
 =?utf-8?B?RDc3aDZMTDBuWWdYVlhJRHYzcXVpZEpTOW1SQngwTkpXUVNINWliR2E4WndN?=
 =?utf-8?B?cEZMQ1RhSHJlemorVlZpb214YXczY1hwcDRoSGo0S3dENFRKczMrdjdIK3N2?=
 =?utf-8?B?REcvTWpHNWw2UEY5NEF4dWFjL2VXcmJFSUw2RE4va1kwUkU3QlhydzEwSFRD?=
 =?utf-8?B?UzczTTJzUnJHVkJRcWNLdWRpRkRQdUYyczJDbkEwVEdTTU9XVStOc2RXOGtE?=
 =?utf-8?B?RC8wU2VvQTFoVTVLTEZwYzBkODFod0pJR3dzNzJsT1lmbDhUSTVTemM0Z1Ns?=
 =?utf-8?B?UDNyUkYzOUF0YjRNY28rTDhtYm43N2ltV0tiWEtMUmNkZDR3c21LSEJyUzZy?=
 =?utf-8?B?R3JQRzc2eklJcGQ3VzFKYzZJOWNyQmRjNWdxUHdFZC9HcXpNMEZqWG5ic29N?=
 =?utf-8?B?TkQrMXpuZDF0cUhTSUlCK3llRXZ0Z0w4ditFelRuam1oQVNMTXo3RzZ3PT0=?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b4435-ea6e-4f36-edd2-08dacc6dcb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:41:56.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ra+ym0+MHCnAOLmZjNweisdeOsAu/3hTbCVDLsuyKUtSM7UAA7s+AZ9CPoGmqBinafvp7eZ7XW+NpoocEJPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8104
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBGcm9tOiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiANCj4gV2UgbmVlZCB0
byBmaWxsIGluIHRoZSB0b3RhbCBFSFMgbGVuZ3RoIGluIFVUUCBUcmFuc2ZlciBSZXF1ZXN0IERl
c2NyaXB0b3IsDQo+IGFkZCB0aGlzIGZ1bmN0aW9uYWxpdHkgdG8gdWZzaGNkX3ByZXBhcmVfcmVx
X2Rlc2NfaGRyKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0BtaWNy
b24uY29tPg0KUmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0K
DQo+IC0tLQ0KPiAgZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyB8IDIxICsrKysrKysrKystLS0t
LS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgYi9kcml2
ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIGluZGV4DQo+IDMxMTE3MjU3OGZkOC4uMjkzNmUxZTU4M2Mz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ICsrKyBiL2RyaXZl
cnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gQEAgLTI1MDgsMTQgKzI1MDgsMTUgQEAgc3RhdGljIHZv
aWQgdWZzaGNkX2Rpc2FibGVfaW50cihzdHJ1Y3QgdWZzX2hiYQ0KPiAqaGJhLCB1MzIgaW50cnMp
ICB9DQo+IA0KPiAgLyoqDQo+IC0gKiB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIoKSAtIEZp
bGxzIHRoZSByZXF1ZXN0cyBoZWFkZXINCj4gKyAqIHVmc2hjZF9wcmVwYXJlX3JlcV9kZXNjX2hk
ciAtIEZpbGwgVVRQIFRyYW5zZmVyIHJlcXVlc3QgZGVzY3JpcHRvcg0KPiArIGhlYWRlciBhY2Nv
cmRpbmcgdG8gcmVxdWVzdA0KPiAgICogZGVzY3JpcHRvciBhY2NvcmRpbmcgdG8gcmVxdWVzdA0K
PiAgICogQGxyYnA6IHBvaW50ZXIgdG8gbG9jYWwgcmVmZXJlbmNlIGJsb2NrDQo+ICAgKiBAdXBp
dV9mbGFnczogZmxhZ3MgcmVxdWlyZWQgaW4gdGhlIGhlYWRlcg0KPiAgICogQGNtZF9kaXI6IHJl
cXVlc3RzIGRhdGEgZGlyZWN0aW9uDQo+ICsgKiBAZWhzX2xlbmd0aDogVG90YWwgRUhTIExlbmd0
aCAoaW4gMzLigJBieXRlcyB1bml0cyBvZiBhbGwgRXh0cmEgSGVhZGVyDQo+ICsgU2VnbWVudHMp
DQo+ICAgKi8NCj4gLXN0YXRpYyB2b2lkIHVmc2hjZF9wcmVwYXJlX3JlcV9kZXNjX2hkcihzdHJ1
Y3QgdWZzaGNkX2xyYiAqbHJicCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdTggKnVwaXVf
ZmxhZ3MsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9uIGNtZF9kaXIpDQo+ICtzdGF0aWMgdm9pZCB1
ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIoc3RydWN0IHVmc2hjZF9scmIgKmxyYnAsIHU4DQo+
ICp1cGl1X2ZsYWdzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gY21kX2RpciwNCj4gK2ludCBlaHNfbGVuZ3RoKQ0KPiAg
ew0KPiAgICAgICAgIHN0cnVjdCB1dHBfdHJhbnNmZXJfcmVxX2Rlc2MgKnJlcV9kZXNjID0gbHJi
cC0+dXRyX2Rlc2NyaXB0b3JfcHRyOw0KPiAgICAgICAgIHUzMiBkYXRhX2RpcmVjdGlvbjsNCj4g
QEAgLTI1MzQsOCArMjUzNSw4IEBAIHN0YXRpYyB2b2lkIHVmc2hjZF9wcmVwYXJlX3JlcV9kZXNj
X2hkcihzdHJ1Y3QNCj4gdWZzaGNkX2xyYiAqbHJicCwNCj4gICAgICAgICAgICAgICAgICp1cGl1
X2ZsYWdzID0gVVBJVV9DTURfRkxBR1NfTk9ORTsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAg
IGR3b3JkXzAgPSBkYXRhX2RpcmVjdGlvbiB8IChscmJwLT5jb21tYW5kX3R5cGUNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8PCBVUElVX0NPTU1BTkRfVFlQRV9PRkZTRVQpOw0K
PiArICAgICAgIGR3b3JkXzAgPSBkYXRhX2RpcmVjdGlvbiB8IChscmJwLT5jb21tYW5kX3R5cGUg
PDwNCj4gVVBJVV9DT01NQU5EX1RZUEVfT0ZGU0VUKSB8DQo+ICsgICAgICAgICAgICAgICBlaHNf
bGVuZ3RoIDw8IDg7DQo+ICAgICAgICAgaWYgKGxyYnAtPmludHJfY21kKQ0KPiAgICAgICAgICAg
ICAgICAgZHdvcmRfMCB8PSBVVFBfUkVRX0RFU0NfSU5UX0NNRDsNCj4gDQo+IEBAIC0yNTkwLDgg
KzI1OTEsNyBAQCB2b2lkIHVmc2hjZF9wcmVwYXJlX3V0cF9zY3NpX2NtZF91cGl1KHN0cnVjdA0K
PiB1ZnNoY2RfbHJiICpscmJwLCB1OCB1cGl1X2ZsYWdzKSAgfQ0KPiANCj4gIC8qKg0KPiAtICog
dWZzaGNkX3ByZXBhcmVfdXRwX3F1ZXJ5X3JlcV91cGl1KCkgLSBmaWxscyB0aGUgdXRwX3RyYW5z
ZmVyX3JlcV9kZXNjLA0KPiAtICogZm9yIHF1ZXJ5IHJlcXVzdHMNCj4gKyAqIHVmc2hjZF9wcmVw
YXJlX3V0cF9xdWVyeV9yZXFfdXBpdSgpIC0gZmlsbCB0aGUgdXRwX3RyYW5zZmVyX3JlcV9kZXNj
DQo+ICsgZm9yIHF1ZXJ5IHJlcXVlc3QNCj4gICAqIEBoYmE6IFVGUyBoYmENCj4gICAqIEBscmJw
OiBsb2NhbCByZWZlcmVuY2UgYmxvY2sgcG9pbnRlcg0KPiAgICogQHVwaXVfZmxhZ3M6IGZsYWdz
DQo+IEBAIC0yNjYyLDcgKzI2NjIsNyBAQCBzdGF0aWMgaW50IHVmc2hjZF9jb21wb3NlX2Rldm1h
bl91cGl1KHN0cnVjdA0KPiB1ZnNfaGJhICpoYmEsDQo+ICAgICAgICAgZWxzZQ0KPiAgICAgICAg
ICAgICAgICAgbHJicC0+Y29tbWFuZF90eXBlID0gVVRQX0NNRF9UWVBFX1VGU19TVE9SQUdFOw0K
PiANCj4gLSAgICAgICB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIobHJicCwgJnVwaXVfZmxh
Z3MsIERNQV9OT05FKTsNCj4gKyAgICAgICB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIobHJi
cCwgJnVwaXVfZmxhZ3MsIERNQV9OT05FLCAwKTsNCj4gICAgICAgICBpZiAoaGJhLT5kZXZfY21k
LnR5cGUgPT0gREVWX0NNRF9UWVBFX1FVRVJZKQ0KPiAgICAgICAgICAgICAgICAgdWZzaGNkX3By
ZXBhcmVfdXRwX3F1ZXJ5X3JlcV91cGl1KGhiYSwgbHJicCwgdXBpdV9mbGFncyk7DQo+ICAgICAg
ICAgZWxzZSBpZiAoaGJhLT5kZXZfY21kLnR5cGUgPT0gREVWX0NNRF9UWVBFX05PUCkgQEAgLTI2
OTAsOA0KPiArMjY5MCw3IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2NvbXBfc2NzaV91cGl1KHN0cnVj
dCB1ZnNfaGJhICpoYmEsIHN0cnVjdA0KPiB1ZnNoY2RfbHJiICpscmJwKQ0KPiAgICAgICAgICAg
ICAgICAgbHJicC0+Y29tbWFuZF90eXBlID0gVVRQX0NNRF9UWVBFX1VGU19TVE9SQUdFOw0KPiAN
Cj4gICAgICAgICBpZiAobGlrZWx5KGxyYnAtPmNtZCkpIHsNCj4gLSAgICAgICAgICAgICAgIHVm
c2hjZF9wcmVwYXJlX3JlcV9kZXNjX2hkcihscmJwLCAmdXBpdV9mbGFncywNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbHJicC0+Y21kLT5zY19kYXRh
X2RpcmVjdGlvbik7DQo+ICsgICAgICAgICAgICAgICB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19o
ZHIobHJicCwgJnVwaXVfZmxhZ3MsDQo+ICsgbHJicC0+Y21kLT5zY19kYXRhX2RpcmVjdGlvbiwg
MCk7DQo+ICAgICAgICAgICAgICAgICB1ZnNoY2RfcHJlcGFyZV91dHBfc2NzaV9jbWRfdXBpdShs
cmJwLCB1cGl1X2ZsYWdzKTsNCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAg
cmV0ID0gLUVJTlZBTDsNCj4gQEAgLTY4NjIsNyArNjg2MSw3IEBAIHN0YXRpYyBpbnQgdWZzaGNk
X2lzc3VlX2Rldm1hbl91cGl1X2NtZChzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhLA0KPiAgICAgICAg
IC8qIHVwZGF0ZSB0aGUgdGFzayB0YWcgaW4gdGhlIHJlcXVlc3QgdXBpdSAqLw0KPiAgICAgICAg
IHJlcV91cGl1LT5oZWFkZXIuZHdvcmRfMCB8PSBjcHVfdG9fYmUzMih0YWcpOw0KPiANCj4gLSAg
ICAgICB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIobHJicCwgJnVwaXVfZmxhZ3MsIERNQV9O
T05FKTsNCj4gKyAgICAgICB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIobHJicCwgJnVwaXVf
ZmxhZ3MsIERNQV9OT05FLCAwKTsNCj4gDQo+ICAgICAgICAgLyoganVzdCBjb3B5IHRoZSB1cGl1
IHJlcXVlc3QgYXMgaXQgaXMgKi8NCj4gICAgICAgICBtZW1jcHkobHJicC0+dWNkX3JlcV9wdHIs
IHJlcV91cGl1LCBzaXplb2YoKmxyYnAtPnVjZF9yZXFfcHRyKSk7DQo+IC0tDQo+IDIuMjUuMQ0K
DQo=
