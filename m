Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D96A51C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjB1DWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1DWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:22:32 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786142597C;
        Mon, 27 Feb 2023 19:22:30 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S2afX0024477;
        Mon, 27 Feb 2023 19:22:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ziCe9VKd3Yz71u254gt6aQF/y650ngYOK4BKEIZR3PA=;
 b=DawWExm9+gQzsHas8SNUrPBNTpPEpuvNg0KzIofdjvItQFmBqRt/OB4aKLpFLypg1SeJ
 uOAhhl/Oi+enRRomCkQM0oe3naYz4zbK91kQtKH/ZZUqYsLj3ce/c7Lg9MBTmrwCdl5b
 Bsd3EJadM+Vfhkm9kVtGPz8H5Ii05Q5E5wGByCnFGbMotQPNoaCHf7HrlzRxDCYR20p/
 7hbNkn/T+hOYKGj3O56w/6OmOA7L5PHoDhdsevBCxxsO9tJwHWshm4gHI5ZF15VFIXSR
 jXfmBX3eglMGoa1hH+IHzQjyTqrIeqjN/aVuGZ1ChdE2NUZZ259Z05/lMVU40CIkPOOM Ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyj51nksh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 19:22:27 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B7B34024F;
        Tue, 28 Feb 2023 03:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677554546; bh=ziCe9VKd3Yz71u254gt6aQF/y650ngYOK4BKEIZR3PA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dJQGRCRdpsInX2rTGILBZwkQOR1s/1azXGVsTaExqaxKyk0K9V20JlDn/n31fIyft
         80lrW+CpIVQcDJddOx71OA6v79vaj3h5+awnEEcmYNfx0u4qYa4xItkSQq/gcIO7s0
         5Z98ouTLBYoF5G6ggi+VRQyI/AE7dknue93BmLkwwI7jhfOjcZDC75DWvJy99stF5n
         6ZQQh1XqzjTLl14hN2UE2YYbTVBAm9ycc+iX/a8fPFVQ1l57JKolZYjTuQ0Pu/iaUL
         M2hpdr2PMueiKw9hfV1fbIag5vrhO3VSJoyXOn09QLiWmrIxWKK8rv23VqUX+sceBd
         tTxdJ2e5KhmJg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 73517A0070;
        Tue, 28 Feb 2023 03:22:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 358AB4006B;
        Tue, 28 Feb 2023 03:22:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tVvf7zWc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEMBRGkXZiqC9L9v55E/o/ehTPJ+qSgNmI+R37hJ79CJLZIXoGjBnYnh3agOZZdrhkBIRJV/0d6Jts30WYkQmCRbe2pQucSnQ52q917E3HeaIz77M0xetXNl/2NqIKahHwjnp5kTPOeOXuT1fYyOI+sj8lbHw8cjLLyFxRDi3Vw6WwKECrzKkB2O7ztZ8zyAEwCRTcdKIf55ZM8ak/QS4lTuWMVvi3XVIveSPyKK6n7La1Sm3DajEBJjVkkX38iz9LSA7+zTOly0fqMxAtGfxPlt1/EUFtBi1/m9VpbsAgq9SsMcHWEoszs8oo9XztDtkW8T45KWSlsnTLnhAy8KrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziCe9VKd3Yz71u254gt6aQF/y650ngYOK4BKEIZR3PA=;
 b=bCUjyNobkNUDowKhhI6IsblqjMpyUU6/02S5mTVioRmNCmi7apcOyp3sJPRedVKJi2pHfejeekgCmUHIHft05qPq54kD6PkJwBWY3GXkyRyXKg2B3Ie/Zrcz8k+1CH71OeSMhFPExgtFTNb6VnIpUhnpCiQ0ueQVAUvswEBnuZZGLcUBBj7IOdBkbBmpqv0UjO8s95wY34HLF/OEJ71zEGq3fQoKWMdqkkj5/vz4+ntKMDlFUhbLec6pystFAkmBXdWVNv6HUVYw3GKqFsKa/32lgVXOAHJKikapMigaSnU5LkoqcDUOWTLIf7w7uO6DC8hPMRk9EoAMMALCeVMFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziCe9VKd3Yz71u254gt6aQF/y650ngYOK4BKEIZR3PA=;
 b=tVvf7zWc4kEr0n7OdtkFcsLi9jAuJcx7ROPhBeqEEcHTfGo/9+v047xxhfwsu3oU3iOv2hMDNIomrdeOCYoKGihyX3Da+qyTnwHI4zndYQwyMPCavMtgWRV3gPC1gsmqAmwVDBfa/bcCV/e2u/PaQR+larhfwhBAH0LrZA09kf0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Tue, 28 Feb
 2023 03:22:19 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 03:22:19 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Topic: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Thread-Index: AQHZSwIl2lqyJq8SIUKTvkcQR1aWb67joCOAgAARgQA=
Date:   Tue, 28 Feb 2023 03:22:19 +0000
Message-ID: <20230228032204.mqpaj5toehxkl5tu@synopsys.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
 <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
In-Reply-To: <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|LV2PR12MB5966:EE_
x-ms-office365-filtering-correlation-id: e834fa16-8047-4d4b-47a8-08db193affc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qoqD36J56KcTpmMtyoGF30DFM2tzghiCsKWDpgf0pi/tGZfRPAcx/4MuCFavMuRBcqPtTDfn/izWt2gPKB3KG7xJ0xhI1ruIEt9PuTm+kn0Y1tD22Mbhpvy8ylQ82q8vYEyvok+GdZIVGuyuyaEEdJLx5D7nbzUD2tWwLUPCdTDTYLfn0FLSUm+J4gpeV32RRlB3DkoUfoTAL6sGSDhRmA6VGcYy10lSXKEw9/y0vAw0alUbQfWWuFfGyHCjksjAjbZFXFLVPCxqmMVd16SzTcvvhYOb7mAkXPIt+XjqrhqJvpkGKkRDrX5kP6Qy1EQY+6uXjJBa66DX+yndXeLQ5sXa+0jFpvYkXFdJORsINUx66lQKpyjhwCAuyxQzcMa11tdlANaaxGPZuJtQRJ7XUL/H7C6F0rn8PM5pAR1hMoSLPs8Ak35VpI//EPZM6zigDYUu3xR2dXTjQfSAszRGMiIExi61zWsStqMTt67IulUq2+Jb9jMqheueArdBLEeNtKQjZhd81LS/0/TxrtczSzLP7SvpEyv9QRJhZ//jX2HT9kdib/k6vG91E+xk/tsNHoqwk6SyYMwAYTmaEfLgoo/lcHv4o3SOsqOLZ2Ea6it3S/gZ7T84hPsKzSxLFkAsJKvNwmYw969AGvC0vlR3Y0hV3kxjsRtVGMmkSQG8kTcgxJXRHJ22UeazpRzAyzXzhbzvJab4O9bLjE//JPyiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199018)(26005)(186003)(6512007)(6486002)(38100700002)(41300700001)(38070700005)(478600001)(6916009)(8676002)(66446008)(4326008)(76116006)(64756008)(66556008)(71200400001)(66476007)(6506007)(66946007)(5660300002)(1076003)(36756003)(86362001)(122000001)(8936002)(54906003)(2616005)(2906002)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRBeHJSMDNORFFKejkwYjJvMy80ZVY0Ukx3NzIyYnNSSkszT20wMkpVMC8z?=
 =?utf-8?B?amVMbjhBbmp4RUFWdnpIUHhnSHBoSTJwVlpJUzFnekc2dU9SQWRDcEhlSFBU?=
 =?utf-8?B?bnMrRUc1Mk9VazhsNUtPT0dPVHNFT1dRZXNWMnEyVUh3Z1h3OEVKamFOOXkz?=
 =?utf-8?B?cjNuR0p5Q05PYlAyKzVPL2Z1VncweHViMVhhck01VFAvN0pxVU5WMndiNXdZ?=
 =?utf-8?B?b29lMmVVK1piYUlrb0poR3hoM3ZFQUFreWgzbE0zMzc5NXdNUVY5M01CTHpl?=
 =?utf-8?B?b1ZZL1g4UzNzVnBBc2pLTmIzRS9pSVZlRnVWZ2pEU1ppUHpoVGR0QnorQkhh?=
 =?utf-8?B?cFB0NER1RDVZbUVBaUFpVUZiRGM4T3JqaElldUdiKzVOZkZFNXRVMEVGSTgw?=
 =?utf-8?B?TXp5SjVkS3NTdURMMUE1RmJzY2hOODFndUNQai9zQnhKSG9NdmtsVEdyNEJQ?=
 =?utf-8?B?VFdxV0tEeVFWWUJCKzlNK1BwZFlkVUxvVk41Wmd6SklNZktGTmxTN0YzbVM3?=
 =?utf-8?B?VDZCdHRybkxBNWUvM3NSb2c2UnAzQzRvZW8reU8vZkF1Wkg5eENCd3VWVFk4?=
 =?utf-8?B?RU5ZMHpwNnFCNm4yZ2F5RHdDZXRTUGpOWHRDa0FJc01aZnZEVHl4UE9rbGRY?=
 =?utf-8?B?R0k5N3RyeVpoNXkrQytqVVUreEVGRlJCNlJSSFk2LzhwZVc0b0xwdTRDR1RL?=
 =?utf-8?B?N1JiME9IRTljY3dHQVBwSUt1aEsyZUY2NUZvdk93dHZQNzVJSzFHdkoyOWc1?=
 =?utf-8?B?eWg2SGZqYlJQRUV2bGRRZ2FFV1RtMlg3LzE3OGNTNWZ0SGZBenB6WkRhNWlp?=
 =?utf-8?B?cE1WMytzM3VPSjNBd3dUbFpWWWhib0N4cGVrWmx3dVplS251VzB5cWcyZVpo?=
 =?utf-8?B?UVpEalNsdFhlTjRnVmdENHZDWStOZVhUVWZ2S3IwbFFFSTVpNnltTVZ4dFJH?=
 =?utf-8?B?TjZWSEs2bEhuY2ZlN0dQUGJkcXkzdWJNamJQbDRibGo4QjRPN0RiQVppbXpM?=
 =?utf-8?B?RVpKQzYrWTR0KzIrVXRtTWVGc2t1QXUrTVRnL3JBNW1mVjZ1ZXd1THJGNG83?=
 =?utf-8?B?Q2dSMFNYWGdEVzMrS0hxeGkxeTlxVVNVLzRVYjlmOVkyYnV2dWpFK2t0VHh3?=
 =?utf-8?B?VEVydkhNRGlFM3ZEZTBEN3crdXliODVZZVc4L2tHUGh0aVFuaDB6Z2pxS1lP?=
 =?utf-8?B?ZVgya1FvTGY2aWp2MkEwTUczZDZTcDZEZWwyZ2FvM09qZTdJTmplRkw0UkMw?=
 =?utf-8?B?dVI2TjFtVmpVRXM5bjJoaGw1SUpKQzBHUUNGcWxVeWVtcHRCUWZoaFhwT1Rl?=
 =?utf-8?B?Qmt0U1JmMmcyMWhvTW16SEl6RUZqN0JxR1ZyeThaZmRQa1kxSGw3WVhwc0w4?=
 =?utf-8?B?K0tCSktMRkJ4cGRYS0JHalpXWmI5c2lybTdKcjJYQWxkVzYzQWxoSmsrZ2NM?=
 =?utf-8?B?VWsrdkRWVnNKR1pwRTJTS2xEVkpZNDM3NXBKalZEWlA5a0RHYUd3cnc4Z0M0?=
 =?utf-8?B?VmtweXpnbUtrZUU0L1RsenV0Zjk4NmUyZEtJSnRUTDRieGwzbGRraGE2aDdp?=
 =?utf-8?B?OURpTUU3STdGTWpMOTc0SG9vVzhuWkdTMWJoV0J6QjVFdlUwN3d5SFJiV2N2?=
 =?utf-8?B?blA2aXlWdkZpUW9YazVDcGFpVW5WaHR2TEsxMEg1TGduOUNyQ2N3eWlSc29a?=
 =?utf-8?B?NU9YSWlhNCtnWlcveTVCNnhsbml6RFV3WDI4ZTRYR3J6UVVpazJRc2hnZ0l6?=
 =?utf-8?B?NEdrVnRiWmlENVlpUjk2ZG9EbjlMeEdkaS9VTm4wMlI0M0VCT2RyMWJyRmZk?=
 =?utf-8?B?TkFNWlMxLzNjUXordnZ1Tlp3VmN3SHAyYitRNlNSdldIeno5SStwenJ2UXpJ?=
 =?utf-8?B?Y3RGVVVnb21xNjExbWZYNU95OHRFeGZ1TVdZK0ZvOFJUcE1YN0lUUENPMk9D?=
 =?utf-8?B?TUovVkREN2lCZjVFTEIyNVBrUXhjTmxySXBmeG5xcW5RbzQ0cjBiWitIVzdY?=
 =?utf-8?B?LzVocnc3enV3UlNpYmxVRWpjNEs2aCtUZG9QMC9SdkZwcUxDYUtoTG5pNHpD?=
 =?utf-8?B?UGNxdjgwZ1hndldjdVA5SmxTRXE5RDFNZGVEK2VpU0lsZnJ5SVdJUFFRYUJT?=
 =?utf-8?Q?SVtDggxf1KdPteKKkswQIc6D5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EF36E7BEC3A2B4A806AF0C952A31893@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nHxP7vEeXmV988ajhOh+6ZJ80OacQFXPpfOc92hdCvRsGbff61Si0BtCxyls6oyAAL3gZnQoNz7zdzPvd6PN8d79Pv0/lzsoXEbFnFiJpBaPqh0xJe3o0GTXs9YVJO8KeDIlBojCS6h2OkCNzkGdPC3N+5xNCeyUB6PPGCBSfdXg+9C1Z3Zn/SENs27UhB08NPMCD3XxeFOb2G6InC9S+WaDTduhvlHaLXD7t7q3yVpWmDFnqgVZFvagEk5B0VJiZqeonfBrbAnUGssBIHV9VTgvviiGgQN4PPhayOYBXe5ofL0cqP8eDSeN5eivLIjyFMA6hKrnWKKRmj5AxJk9BDnbUOFr7+xRiphOhVkZaIoxAo/WCareJ/Crgbk8W9mjCnQ89oLXyLAaGYh/2uuIEMiQP1EwF00gplXzA026AllaJui/Xfmaka9fO1V5jebxelvEB8qXjVGQsjAvln2sOS4iEGh8ezmaGW0cfaiAzqlRSKh1WTpD5qTsjLeknZMopdhN8mK2e+L/vHA7rkw1oGS5w2jm/nhCu3SYqvV+b/wbaPH359BiVI7m4T1yKB4hrvEtcWWCIH0H/9NHM2ftZEZiQCCvVPKYawyxZLgoTj2hhI4pqL5v60mH9F0nzDtOHXtds3vJuY48rdXIE6c2MChnuWvofRf3+sTxYQ3GF3/Lwx8Je1cbxgcLn/ffjvYSQ+o5AVloxkcv6XHWC/MJla1gFCOjY65UgEjuMxmAxcECkHvmXR9RaOKemTIMyUd7zYODVk8LQw5JUTCPtXxwsh/AGCtyraRQ5uqBN3MytMbPtqq40W2boa5JwCuy3KBSguIi5+hm/9uE8CAxa9wkiU5m+jTbMGlBafcFaNVDX0B6s2HPqfRn2m3PauUE6I4G03BNokMDSdx7QRgq0A04kg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e834fa16-8047-4d4b-47a8-08db193affc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 03:22:19.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDfEObmyq6T5GNXOMSsa31FC7QeKsUkTVgrQMiaDz1pvlzr/ZMzveqEaJltX0lje0toIHAk1M7SQOgzC60SuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Proofpoint-GUID: fx_wbfCTFA4t55iac24VPY8TiyNmIQub
X-Proofpoint-ORIG-GUID: fx_wbfCTFA4t55iac24VPY8TiyNmIQub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 mlxlogscore=877 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjgsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBGZWIg
MjcsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gPiBQcmV2aW91c2x5LCB0aGVyZSB3YXMg
YSAxMDB1UyBkZWxheSBpbnNlcnRlZCBhZnRlciBpc3N1aW5nIGFuIGVuZCB0cmFuc2Zlcg0KPiA+
IGNvbW1hbmQgZm9yIHNwZWNpZmljIGNvbnRyb2xsZXIgcmV2aXNpb25zLiAgVGhpcyB3YXMgZHVl
IHRvIHRoZSBmYWN0IHRoYXQNCj4gPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxkIHdoaWNo
IGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gPiBlbmQgdHJhbnNmZXIg
Y29tbWFuZCBvbmNlIHRoZSBDTURBQ1QgYml0IHdhcyBjbGVhcmVkIGluIHRoZSBERVBDTUQNCj4g
PiByZWdpc3Rlci4gIFNpbmNlIHRoaXMgYml0IGRvZXMgbm90IGV4aXN0IGZvciBhbGwgY29udHJv
bGxlciByZXZpc2lvbnMsIGFkZA0KPiA+IHRoZSBkZWxheSBiYWNrIGluLg0KPiA+IA0KPiA+IEFu
IGlzc3VlIHdhcyBzZWVuIHdoZXJlIHRoZSBVU0IgcmVxdWVzdCBidWZmZXIgd2FzIHVubWFwcGVk
IHdoaWxlIHRoZSBEV0MzDQo+ID4gY29udHJvbGxlciB3YXMgc3RpbGwgYWNjZXNzaW5nIHRoZSBU
UkIuICBIb3dldmVyLCBpdCB3YXMgY29uZmlybWVkIHRoYXQgdGhlDQo+ID4gZW5kIHRyYW5zZmVy
IGNvbW1hbmQgd2FzIHN1Y2Nlc3NmdWxseSBzdWJtaXR0ZWQuIChubyBlbmQgdHJhbnNmZXIgdGlt
ZW91dCkNCj4gDQo+IEN1cnJlbnRseSB3ZSBvbmx5IGNoZWNrIGZvciBjb21tYW5kIGFjdGl2ZSwg
bm90IGNvbXBsZXRpb24gb24gdGVhcmRvd24uDQo+IA0KPiA+IEluIHNpdHVhdGlvbnMsIHN1Y2gg
YXMgZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KCkgYW5kDQo+ID4gX19kd2MzX2dhZGdldF9l
cF9kaXNhYmxlKCksIHRoZSBkd2MzX3JlbW92ZV9yZXF1ZXN0KCkgaXMgdXRpbGl6ZWQsIHdoaWNo
DQo+ID4gd2lsbCBpc3N1ZSB0aGUgZW5kIHRyYW5zZmVyIGNvbW1hbmQsIGFuZCBmb2xsb3cgdXAg
d2l0aA0KPiA+IGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkuICBBdCBsZWFzdCBmb3IgdGhlIFVTQiBl
cCBkaXNhYmxlIHBhdGgsIGl0IGlzDQo+ID4gcmVxdWlyZWQgZm9yIGFueSBwZW5kaW5nIGFuZCBz
dGFydGVkIHJlcXVlc3RzIHRvIGJlIGNvbXBsZXRlZCBhbmQgcmV0dXJuZWQNCj4gPiB0byB0aGUg
ZnVuY3Rpb24gZHJpdmVyIGluIHRoZSBzYW1lIGNvbnRleHQgb2YgdGhlIGRpc2FibGUgY2FsbC4g
IFdpdGhvdXQNCj4gPiB0aGUgR1VDVEwyIGJpdCwgaXQgaXMgbm90IGVuc3VyZWQgdGhhdCB0aGUg
ZW5kIHRyYW5zZmVyIGlzIGNvbXBsZXRlZCBiZWZvcmUNCj4gPiB0aGUgYnVmZmVycyBhcmUgdW5t
YXBwZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVu
Z0BxdWljaW5jLmNvbT4NCj4gDQo+IFRoaXMgaXMgZXhwZWN0ZWQuIFdlJ3JlIHN1cHBvc2VkIHRv
IG1ha2Ugc3VyZSB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQNCj4gY29tcGxldGUgYmVmb3JlIGFj
Y2Vzc2luZyB0aGUgcmVxdWVzdC4gVXN1YWxseSBvbiBkZXZpY2UvZW5kcG9pbnQNCj4gdGVhcmRv
d24sIHRoZSBnYWRnZXQgZHJpdmVycyBkb24ndCBhY2Nlc3MgdGhlIHN0YWxlL2luY29tcGxldGUg
cmVxdWVzdHMNCj4gd2l0aCAtRVNIVVRET1dOIHN0YXR1cy4gVGhlcmUgd2lsbCBiZSBwcm9ibGVt
cyBpZiB3ZSBkbywgYW5kIHdlIGhhdmVuJ3QNCj4gZml4ZWQgdGhhdC4NCj4gDQo+IEFkZGluZyAx
MDB1UyBtYXkgbm90IGFwcGx5IGZvciBldmVyeSBkZXZpY2UsIGFuZCB3ZSBkb24ndCBuZWVkIHRv
IGRvDQo+IHRoYXQgZm9yIGV2ZXJ5IEVuZCBUcmFuc2ZlciBjb21tYW5kLiBDYW4geW91IHRyeSB0
aGlzIHVudGVzdGVkIGRpZmYNCj4gaW5zdGVhZDoNCj4gDQo+IA0KDQpOZWVkIHRvIG1ha2Ugc3Vy
ZSBGb3JjZVJNPTAgZm9yIHRoZSBUUkIgdG8gYmUgdXBkYXRlZC4gVHJ5IHRoaXMgaW5zdGVhZDoN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQppbmRleCAzYzYzZmE5N2E2ODAuLjU1ZjQ4ZmM1ODQ0YSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCkBAIC0xNjg2LDYgKzE2ODYsMzQgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2dl
dF9mcmFtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KIAlyZXR1cm4gRFdDM19EU1RTX1NPRkZOKHJlZyk7
DQogfQ0KIA0KK3N0YXRpYyBpbnQgZHdjM19wb2xsX2VwX2NvbXBsZXRpb24oc3RydWN0IGR3YzNf
ZXAgKmRlcCkNCit7DQorCWlmICghbGlzdF9lbXB0eSgmZGVwLT5zdGFydGVkX2xpc3QpKSB7DQor
CQlzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXE7DQorCQlpbnQgdGltZW91dCA9IDUwMDsNCisNCisJ
CXJlcSA9IG5leHRfcmVxdWVzdCgmZGVwLT5zdGFydGVkX2xpc3QpOw0KKwkJd2hpbGUoLS10aW1l
b3V0KSB7DQorCQkJLyoNCisJCQkgKiBOb3RlOiBkb24ndCBjaGVjayB0aGUgbGFzdCBlbnF1ZXVl
ZCBUUkIgaW4gY2FzZQ0KKwkJCSAqIG9mIHNob3J0IHRyYW5zZmVyLiBDaGVjayBmaXJzdCBUUkIg
b2YgYSBzdGFydGVkDQorCQkJICogcmVxdWVzdCBpbnN0ZWFkLg0KKwkJCSAqLw0KKwkJCWlmICgh
KHJlcS0+dHJiLT5jdHJsICYgRFdDM19UUkJfQ1RSTF9IV08pKQ0KKwkJCQlicmVhazsNCisNCisJ
CQl1ZGVsYXkoMik7DQorCQl9DQorCQlpZiAoIXRpbWVvdXQpIHsNCisJCQlkZXZfd2FybihkZXAt
PmR3Yy0+ZGV2LA0KKwkJCQkgIiVzIGlzIHN0aWxsIGluLXByb2dyZXNzXG4iLCBkZXAtPm5hbWUp
Ow0KKwkJCXJldHVybiAtRVRJTUVET1VUOw0KKwkJfQ0KKwl9DQorDQorCXJldHVybiAwOw0KK30N
CisNCiAvKioNCiAgKiBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIgLSBzdG9wIHRoZSBjdXJy
ZW50IGFjdGl2ZSB0cmFuc2Zlcg0KICAqIEBkZXA6IGlzb2MgZW5kcG9pbnQNCkBAIC0xNzAzLDYg
KzE3MzEsOSBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3Qg
ZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KIAl1MzIgY21kOw0KIAlpbnQgcmV0
Ow0KIA0KKwlpZiAoIWludGVycnVwdCkNCisJCWZvcmNlID0gZmFsc2U7DQorDQogCWNtZCA9IERX
QzNfREVQQ01EX0VORFRSQU5TRkVSOw0KIAljbWQgfD0gZm9yY2UgPyBEV0MzX0RFUENNRF9ISVBS
SV9GT1JDRVJNIDogMDsNCiAJY21kIHw9IGludGVycnVwdCA/IERXQzNfREVQQ01EX0NNRElPQyA6
IDA7DQpAQCAtMTcyMiwxMCArMTc1MywxMiBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KIAlX
QVJOX09OX09OQ0UocmV0KTsNCiAJZGVwLT5yZXNvdXJjZV9pbmRleCA9IDA7DQogDQotCWlmICgh
aW50ZXJydXB0KQ0KKwlpZiAoIWludGVycnVwdCkgew0KKwkJcmV0ID0gZHdjM19wb2xsX2VwX2Nv
bXBsZXRpb24oZGVwKTsNCiAJCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfVFJBTlNGRVJfU1RBUlRF
RDsNCi0JZWxzZSBpZiAoIXJldCkNCisJfSBlbHNlIGlmICghcmV0KSB7DQogCQlkZXAtPmZsYWdz
IHw9IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQorCX0NCiANCiAJZGVwLT5mbGFncyAm
PSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KIAlyZXR1cm4gcmV0Ow0KDQpUaGFua3MsDQpUaGluaA==
