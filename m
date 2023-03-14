Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403886BA089
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCNURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:16:58 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935F22DF8;
        Tue, 14 Mar 2023 13:16:57 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EIVueO016596;
        Tue, 14 Mar 2023 13:16:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XGPHkMr4ph5Fin16yDxsfInr+ENOyc2+Lzi3ArB1e0k=;
 b=fknMWy4w9kfSe5iA/VsuD2pGneQUeQYPPIZePC6aPzah+Wl0GAveN5ssjTiXW1YJi30x
 WdbTNGJMABzQ5uAcmaIukeun+Qv9/XX7NU1WoiQz7fON26l8gL6Ky4qEYBdIrsu55WBa
 K/cxw6/YxFD3W6vqMdG5WF6J5PJ5Vj2hoMsKY3nv6UUNTfaSNVEnKkFgrw9lp7aTVnrL
 8PXphkr/ouAWML+o6nW6j1+/posLm9QkJFDNVb/aAlEBVs/xicjYoP3KkWPzkPm3H/BF
 fv7wUeYPAXg4Nh/rK9g6UTTLdwssNanOhw4n9IuwxR/LbxnWwGgDVJPZ26YScij4T4AP DA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p92fudtyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 13:16:50 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F377C04BF;
        Tue, 14 Mar 2023 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678825009; bh=XGPHkMr4ph5Fin16yDxsfInr+ENOyc2+Lzi3ArB1e0k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QH5EkA1RD/+Zf8RVRAWxomSOfMWS1KluPL2ZRSw2aTerd+7FEMKTVpnpn7DRb2iVZ
         OROtsIl/gSExFo5i3uiejUfYsLAGiHwope2xqe42XZl7f1n6BiytsKO6SacuzCnvyZ
         XtDkzJMDmaawjsQJq3GK74uX14dh39sfDrF+pm2VjmhVL4pyLLjLt4WE/DDJE0qUkE
         sja5BFmBpVDRsz6/XtXPmDhkBKDu/u5Rkt1eJSZEMctoNMwVV+fNuE9qks6PZoaZwy
         IKJWUjjUT85p2EydvFkvS4bJK7O/Cy+aZ7bPlIy03UOvmp/mWM3kSyAYTIF4rs4pen
         XfgmDE1UJ+RHQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DDC67A0060;
        Tue, 14 Mar 2023 20:16:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 917D9800BD;
        Tue, 14 Mar 2023 20:16:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lGaCkhH5";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFEHzih+70O/WeTUlmdXsiUz4Um1MVMELVwc9zTgPZiiAVEeyG1XizZTkKlkiAYmLt6TsGA1v2abJC1vdMfplUMaC0yQcGn2/+DMWh1XeIpnmy4SFurWWEoAYbS4Yq0l+n93kfk30nmulYagSew7Sr9zax+pu3lxifVTK1OCy6UIUod9DfK+D7KItE2uAM/LGwtxiVGFBMkZtw8nlJdlx/7ydP2BCBCm3PUQe+dctNvbfbC2aOrHZVrCbG5CcDeD7XoMDviey/k0Y/8OeHNwh4nkNDYr7kAxOhWd+dq/7XHJhH2r2qErTXSaXuuWZVEMciwTtKZ1aBi0H/bXQgxJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGPHkMr4ph5Fin16yDxsfInr+ENOyc2+Lzi3ArB1e0k=;
 b=l5ulm3LFTRZ51Hb/P5gn+lZ/0Xu9yTfsrXy+8sJUN5cHqdSDEms/MKPQYtB2OxNwH9lNYHtk8VFn9azRRqyLoYpbrnVNICgG9Y5enhguz4pkjjOoWpHukoLtchrNNwvIY26phVDkHzj/KbWr/sGnezSe20Fq1Buc6mNLZ9VXSP0CuhVQsUmMAquXwS9hd4vq1PRZsNqe6TyAFrKUfdrxC4bT2aJhAdwj+THcZEMqVvohyMhTQ2QCudt9jkrQaRFEYIAHKastgnKtieupdPIv2cfAOOy/60XDiwUq5OY/uWmJDjBWaTFI4aI5m7Sp69icIVcF4zzE9OgDs+q5NpLrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGPHkMr4ph5Fin16yDxsfInr+ENOyc2+Lzi3ArB1e0k=;
 b=lGaCkhH5m0zL397MvnJsSAA5BK8csbMxEe/Hu7KT4ov97TOBYOPvzLeL+PRHgsP276UPIrGXJu4RDvkD4MJIQ362SbM1FwV9qKHaVaWAlgvZ+UR3be2hWZfwk5M9d/9Ig/Jkk68MwJV54VcsaPr/6fwAnhwIpgPll6Y0B7uSMj4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 20:16:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 20:16:44 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Index: AQHZVdkm2qliMtpSnkaUilVaMBFAZa75KJuAgAGELgCAAAtFAA==
Date:   Tue, 14 Mar 2023 20:16:44 +0000
Message-ID: <20230314201636.mfmjrgluckyk5xhy@synopsys.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
 <20230313202655.srqfddpn5r36zt3o@synopsys.com>
 <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
In-Reply-To: <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6714:EE_
x-ms-office365-filtering-correlation-id: d036c066-fa2e-4c9e-432d-08db24c907df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxwv5yRgvmmYL0K+FRRX3H4MicTWitWUUlv1vb90mkWpzDujq2C7sZNi7H5SySGC34+SfTtd394Qj0SCZnlBuWztv3MqB1HH51+DYURDTBIpiFYaldbJsY6teKEcKLuQfMX/ogW5QjVbL8/t4KeG6BgeBPLRilkcHqJHt7BOhZzLcxUvTR6iBe/gpvXKLDy5LDSQa4GRhCHJCKwN7x9SAVw7qi0m63RpwYGm1xN6MFYSH7oRMvlVuhnzL0dg7vI+lemQKRVz9Wef/GZIgQe+kbClb1Hg4EIUslIQ3bhbiTxIiGB0BfpsicC0Hfbpl0YWUcCXuhjBK5KFquqEBDiutygN1HM1WOGS9IpwTVNt5ku+/1rfyS2DXe4jGSX/RovKL7PTjGqSKbShasOmMVWU93b2Vodbk2Kf1Bf9vvdB/nNuTXZ9ID84OtD/3qOZTMEC2ee4RjanGcXVNbrGf/kB5gi5xZNC1Jpyx9eAUc8P0ExZYsHE2HKXtZyBZphZPCze633pg/iBtXCxRwFJlRjGequS5d7FT1jzN72ve5H6pRg79ZPo1kefbx5hLh/vGTD48qJOMYGN1AkPjhCv8PsCbtHGxCODrprFlukCiof+/0ZLKrzEnTlI7FJIsORXJSK14wxwsTvVgV949IutvdrIxbw/PJLuqQRAIQRZOvAJwX2H846C0X0av4oqjNOYLPMxy+ad/nW6+KcabIuC6pKeAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(5660300002)(4326008)(8936002)(6512007)(2616005)(41300700001)(53546011)(186003)(26005)(1076003)(6506007)(6916009)(86362001)(36756003)(83380400001)(15650500001)(2906002)(66476007)(76116006)(6486002)(66946007)(8676002)(66446008)(478600001)(71200400001)(64756008)(316002)(54906003)(38070700005)(66556008)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djFYemlSdTZCalhxQXo5dHp0MFc0WXZ6TjdjMHpxMXRRUmVDUk5VVDdldHVs?=
 =?utf-8?B?Nk4yOVkvM2JteTRRanpiVmZTR2kyNWM2OExCbEJ5b3pjTUlhY0NaTkQ4WjBr?=
 =?utf-8?B?dVBGSGNGNmNVNkhyVVlWZDJoMkhSOXlGcFFNMXN3dCt0L3lFRHhNYmExMytS?=
 =?utf-8?B?L09mNklaSEZWL1VHampSM3h0ZnkzMlUxM2Iwa0RPeXkrVWZkbkY5U3VDUDhT?=
 =?utf-8?B?SDRkZ2xmNlRXc2FGZCtzMnBNVHQ5UVRqL3pPOHpuQXUxZjNwelNVSkg2emJj?=
 =?utf-8?B?ZVoxVHlFR0NxZ0NXay85cGdySEVOZ3VRKzhyVUcrWStjMkQ5QXZ2ZlNDMW1R?=
 =?utf-8?B?Si9VQjdmNTdJRHFtS3lzVUVNTWNFcHZZREtaWTk1dGY3aFBlMkN2U0o4NGJQ?=
 =?utf-8?B?K3hGY21hMGZtSHNxNFBRQ2hhRm9xY1FheURPQXU0UTNDak16RlBtblpYMU95?=
 =?utf-8?B?N20yY0NwSUR6ZFNjTkh1U3ZzSjN4SDVRVnRiR1hmR0FkSkpSdzlKZ0NHOVhM?=
 =?utf-8?B?cEtiVGxzS2lVak15Sms4NUpqMjhLMTdBQ2x2dFJGZHhtbk5PMjhxUTgzV2JM?=
 =?utf-8?B?MmN3dHA0aHc0a2p4cnlDMm40UitybnJSYnBqS3ZJV2o3ZDVzZjlCTzBCbUhL?=
 =?utf-8?B?NHd0N1U0UThoSnVxNll6ZVBodnRnOXVKUVZkcjd6T3NieUJiaUF2ZWdLWXVF?=
 =?utf-8?B?UHgwT3h2MTUrM2YzclEyNEhjY3QyRTJaTEdQNU41SHAxNGsvNHZVWWpzTSti?=
 =?utf-8?B?Q3FhN2JhWS9sWC8zNWZZdGd6VVBjUzZCTXZrRmFZbHc5cUR3d0ZjTGdZRU9h?=
 =?utf-8?B?eXBzZmNiMkhJY0VHS1daWW1oT2V5RFdXakFnN1FSaFF3TGhneG14bHBSR093?=
 =?utf-8?B?VXJrZ0llMVUzUHkrM3lIc0ZycTJNaTIxL21hL3lYZng4cG1DdEwwS0pUcTJy?=
 =?utf-8?B?dm55cWQrNks5WjNLUENXUlA4Rm9mVXhnVHZGSFZFcTc3RnVNN2F6NkpyVEhn?=
 =?utf-8?B?aHhBYkJFelR3SGdCSFlsOFNyaXUxLzNMdWZrNHNrb0FtZnYxL3hkRU9tSHRC?=
 =?utf-8?B?OUFZU1JqaVJWUVBoM0hLQnhneEQzb2R4SGRUY1R2QXRuZTZXbWptYkE0Q3lB?=
 =?utf-8?B?c1F6c3lZNE5FMkhOSHJrVlR2QmVFZnNLTWw1cUxuMU1EWTEzQUg5ZjVxbTJD?=
 =?utf-8?B?aEVXMHNkKzdwMzBFcU5sU1VMa0ZOcy9OL2NBUENBWjl0VTF3Q2xOTWJBYWc3?=
 =?utf-8?B?TUdza0ZtZVRmckR0Nlp2bnRBTkVOb3dOSFI2cTZZZUkrZGZyd1lDNUplSG13?=
 =?utf-8?B?M2pLQ0tUdU9ORXdyZktGYUN4TVQzclVzZ05UeFlkUXFlVm50alVhT3pNOXN4?=
 =?utf-8?B?eEpDSnJyeWVxcU5VU3dnMXd5VW9MangyUm5raEk3dDV6SmJzdkVSYUpFZ1VY?=
 =?utf-8?B?aVp6bjcwYmxFZ3NMaVE1dVZOUVZsUEpCNEg5K2FOck00OWZpYm1zVEluY2R4?=
 =?utf-8?B?QmNoK1l2VmttYlZ5QzF4MjdHaGMvKzl2emhBek01SUJPL2I4VlNGODY3K3FV?=
 =?utf-8?B?ZDBOQXZHd1d2Y2V6Y24vQVR2MWVUQ0JueTcvcXVURERKVzVNbE5xeEdHL1dH?=
 =?utf-8?B?eCsrMlR5NVJrY2w3MzhzOE1XQU9zNXpoQ00wTi84MVh1bm16YXpqMUhpSm1L?=
 =?utf-8?B?d1oramtjWWNneGhkN085bTVLWkFISGpKQWhrWnd4K05qWHNhUkRTenZiS2J0?=
 =?utf-8?B?QU1NQXJUSmJWb09DRTlTZVBJajVQdU5iNGVLM0xrcXhKQzNNRHF4ZEx2Qmly?=
 =?utf-8?B?cFkzMnhuMjhEV2dnczhMeUNTaFVER3JyNTFoU2RrNXQ5SGVYTEQ5VDRickF0?=
 =?utf-8?B?QlJzS1YyMG42UlpTUlpjTk9MUEJHNGtCVEZkTXN1cVZuZHlZanpmYjVDV3Zz?=
 =?utf-8?B?V0tPdU9GNHBHL1JMN05zTUcxVmxNYWRqRXBaaE50V1dCeGV1bkttNGxSbkxO?=
 =?utf-8?B?T1M4bm1sdmdGdUZsdHg2MjA4a1NZMkNDeVlzOEl3MWZUNit1QXZxNllibGhL?=
 =?utf-8?B?SXpSbmNTUU1SZlBoNy9BTXpodVVGRFN4NnVsS2xXMG9CU01RN3Q5Ull3THMr?=
 =?utf-8?Q?3+tmRviuaaNobV4ys62VCfZfN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <222CFD40654A4B498AB3FF20ED719D03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jlC3oZ+WNHgos75ncJry0T4hF6FHRpIWbAU8+lcMxffDK9evQjQahJemSvEpqG3K5PoFBHV93T0sEJ4v4KijMNrYWTeUWOZp17iKD0XhmaKWfo+SrxkV1x6XTkTgzX8GYjIJTMH83RZN66KRcXm3zav7C/xi2eC0tP4npev9IGcdqQi0x0Am5BoDc5SUZdRQ0qHePeG4jRmmJqOOj4Mc8//5z+TTD9XVFMTMpNx0Frx9zY1kJcFY3YUL7msyuF/zNgM+J/rumaFK/397e2jyUtiaRWUaOVqn/chdRPlsprD8GTyGAgJIdh2ulb3cP86jDztpOeJVIhP5Gl5KUs5GyjplDYBMyPQKTC0StuNQH2iTuvtA7s8dO2467PUM30nq+kTC1VpdTYwMe03hq6xh0SS1hvVhdCNUte7CzlV2JE5lgTM13x4lvLFo5WOmHAZadDioUb/paxv/aT5ayK7m20XoqLYP0CXD49tTbkHetaGUr8scUPk94vYnw0Yo5EsbTfkkBFCaB59H8eN5ocNsLstcM0GRj62PZXscXb4pUUFxl6tlHSEQD9JeRfxZNm06QKwz/HJ4J+W/fyuq7Tql4J7Gb+P+U8MEwU+2WUoDt9r6J9XO36/KyL+L4ZAavMOeB73XerKfRgPUiJ5A1aFZ54oKK8zWzlhtYP+cNhgXWRW4GaGH/pUy1RMIAzJMwgtZpTlZioG+GtjNATcarI8pubuFjC/RJe+80NWWfV1HXGH4jtM5rgCuKzBrnD+EanLLqTBVoIGcEBXgItNzz2GbuOklNzH6nTXPqRkoUA8AwOHGJysV4L2QK+fyiqQIY545nJPj3iT3zYhjbur+46p1RPoeAyQqNe1+m7rZiDP/r45kvV0fxstoHjFT+HCWBVBHdeOvMpake6ZpmESdxJrGfJfZV37K+hXjCCH1JbgSkE0=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d036c066-fa2e-4c9e-432d-08db24c907df
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 20:16:44.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZiSAiYDfRCPAJ9mWb9d9lHz9qU/zUB6SmO6eobWZRPRv5pltLUIGx2pAVbnVYROY+fuYg75d1+eMHIMHYEC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
X-Proofpoint-GUID: WvvaPPLhwQbWMLlLZ7axTkC4R75dO2a5
X-Proofpoint-ORIG-GUID: WvvaPPLhwQbWMLlLZ7axTkC4R75dO2a5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_12,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMTQsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzEzLzIwMjMgMToyNyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgTWFyIDEz
LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gV2hlbiBob3N0IHNlbmRzIGEg
c3VzcGVuZCBub3RpZmljYXRpb24gdG8gdGhlIGRldmljZSwgaGFuZGxlDQo+ID4gPiB0aGUgc3Vz
cGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3VwZXINCj4g
PiA+IHNwZWVkIGRldmljZXMgY2FuIHN1cHBvcnQgZnVuY3Rpb24gc3VzcGVuZCBmZWF0dXJlIHRv
IHB1dCB0aGUNCj4gPiA+IGZ1bmN0aW9uIGluIHN1c3BlbmQgc3RhdGUuIEhhbmRsZSBmdW5jdGlv
biBzdXNwZW5kIGNhbGxiYWNrLg0KPiA+ID4gDQo+ID4gPiBEZXBlbmRpbmcgb24gdGhlIHJlbW90
ZSB3YWtldXAgY2FwYWJpbGl0eSB0aGUgZGV2aWNlIGNhbiBlaXRoZXINCj4gPiA+IHRyaWdnZXIg
YSByZW1vdGUgd2FrZXVwIG9yIHdhaXQgZm9yIHRoZSBob3N0IGluaXRpYXRlZCByZXN1bWUgdG8N
Cj4gPiA+IHN0YXJ0IGRhdGEgdHJhbnNmZXIgYWdhaW4uDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYyAgIHwgNjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuYyB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmggfCAg
NCArKysNCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiA+ID4gaW5kZXggYTdhYjMw
ZS4uZDUwYzFhNCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi9mX2VjbS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20u
Yw0KPiA+ID4gQEAgLTYzMyw2ICs2MzMsOCBAQCBzdGF0aWMgdm9pZCBlY21fZGlzYWJsZShzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gICAJdXNiX2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkp
Ow0KPiA+ID4gICAJZWNtLT5ub3RpZnktPmRlc2MgPSBOVUxMOw0KPiA+ID4gKwlmLT5mdW5jX3N1
c3BlbmRlZCA9IGZhbHNlOw0KPiA+ID4gKwlmLT5mdW5jX3dha2V1cF9hcm1lZCA9IGZhbHNlOw0K
PiA+ID4gICB9DQo+ID4gPiAgIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovDQo+ID4gPiBAQCAtODg1LDYg
Kzg4Nyw2OCBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZWNtX2FsbG9j
X2luc3Qodm9pZCkNCj4gPiA+ICAgCXJldHVybiAmb3B0cy0+ZnVuY19pbnN0Ow0KPiA+ID4gICB9
DQo+ID4gPiArc3RhdGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikN
Cj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+
ID4gPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNv
bmZpZy0+Y2RldjsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKSB7DQo+
ID4gPiArCQlEQkcoY2RldiwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsNCj4gPiA+
ICsJCXJldHVybjsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlEQkcoY2RldiwgIkVDTSBT
dXNwZW5kXG4iKTsNCj4gPiA+ICsNCj4gPiA+ICsJZ2V0aGVyX3N1c3BlbmQoJmVjbS0+cG9ydCk7
DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3RydWN0
IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBmX2VjbSAqZWNtID0g
ZnVuY190b19lY20oZik7DQo+ID4gPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9
IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+
ICsJICogSWYgdGhlIGZ1bmN0aW9uIGlzIGluIFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwg
cmVzdW1lIGlzDQo+ID4gPiArCSAqIGNhbmNlbGVkLiBJbiB0aGlzIGNhc2UgcmVzdW1lIGlzIGRv
bmUgYnkgYSBGdW5jdGlvbiBSZXN1bWUgcmVxdWVzdC4NCj4gPiA+ICsJICovDQo+ID4gPiArCWlm
IChmLT5mdW5jX3N1c3BlbmRlZCkNCj4gPiA+ICsJCXJldHVybjsNCj4gPiA+ICsNCj4gPiA+ICsJ
REJHKGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gPiA+ICsNCj4gPiA+ICsJZ2V0aGVyX3Jlc3Vt
ZSgmZWNtLT5wb3J0KTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBlY21f
Z2V0X3N0YXR1cyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gK3sNCj4gPiA+ICsJcmV0
dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlcgOiAwKSB8
DQo+ID4gPiArCQlVU0JfSU5UUkZfU1RBVF9GVU5DX1JXX0NBUDsNCj4gPiANCj4gPiBOZWVkIHRv
IGNoZWNrIHRoZSB1c2IgY29uZmlndXJhdGlvbiBpcyBpZiBpdCdzIHdha2V1cF9jYXBhYmxlLg0K
PiA+IA0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGVjbV9mdW5jX3N1c3Bl
bmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZiwgdTggb3B0aW9ucykNCj4gPiA+ICt7DQo+ID4gPiAr
CXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+ID4gPiArCXN0cnVjdCB1c2Jf
Y29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4gPiA+
ICsNCj4gPiA+ICsJREJHKGNkZXYsICJmdW5jIHN1c3AgJXUgY21kXG4iLCBvcHRpb25zKTsNCj4g
PiA+ICsNCj4gPiA+ICsJZi0+ZnVuY193YWtldXBfYXJtZWQgPSAhIShvcHRpb25zICYgKFVTQl9J
TlRSRl9GVU5DX1NVU1BFTkRfUlcgPj4gOCkpOw0KPiA+IA0KPiA+IFNhbWUgaGVyZS4gQ2hlY2sg
Y29uZmlnJ3MgYm1BdHRyaWJ1dGVzIGlmIGl0J3MgcmVtb3RlIHdha2V1cCBjYXBhYmxlDQo+ID4g
YmVmb3JlIGFybWluZyBmb3IgcmVtb3RlIHdha2V1cC4NCj4gPiANCj4gRG9uZS4gSSB3aWxsIGFk
ZCB0aGF0IGNoZWNrIGZvciBhYm92ZSB0d28gY2FzZXMuDQo+ID4gPiArDQo+ID4gPiArCWlmIChv
cHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkpIHsNCj4gPiA+ICsJCWlm
ICghZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiA+ICsJCQllY21fc3VzcGVuZChmKTsNCj4gPiA+
ICsJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IHRydWU7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0gZWxz
ZSB7DQo+ID4gPiArCQlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiA+ICsJCQlmLT5mdW5j
X3N1c3BlbmRlZCA9IGZhbHNlOw0KPiA+ID4gKwkJCWVjbV9yZXN1bWUoZik7DQo+ID4gPiArCQl9
DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gDQo+ID4gTmVlZCB0
byByZXR1cm4gbmVnYXRpdmUgZXJyb3IgaWYgU2V0RmVhdHVyZSBmYWlscy4gV2Ugc2hvdWxkIGZp
eCB0aGUNCj4gPiBjb21wb3NpdGUgbGF5ZXIgdG8gYWxsb3cgZm9yIHByb3RvY2FsIFNUQUxMIGhl
cmUuIEhvc3QgbmVlZHMgdG8ga25vdyBpZg0KPiA+IGl0IHNob3VsZCBwcm9jZWVkIHRvIHB1dCB0
aGUgZnVuY3Rpb24gaW4gc3VzcGVuZC4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4g
PiANCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgY2xhcmlmeSB3aGF0IFNldEZlYXR1cmUgZmFpbCBo
ZXJlIG1lYW5zPyBUaGUgaG9zdCBwdXRzIHRoZQ0KPiBmdW5jdGlvbiBpbiBmdW5jdGlvbiBzdXNw
ZW5kIHN0YXRlIHRocm91Z2ggdGhpcyBTZXRGZWF0dXJlIHJlcXVlc3QuDQo+IElmIHRoZSBkZXZp
Y2UgaXMgbm90IGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAgKGJtQXRycmlidXRlcyB3YWtl
dXAgYml0KSwNCj4gbGlrZSB5b3UgbWVudGlvbmVkIGFib3ZlIHdlIHNob3VsZCBub3QgYXJtIHRo
ZSBmdW5jdGlvbiBmb3IgcmVtb3RlIHdha2V1cC4NCj4gQnV0IHRoZSBob3N0IGlzIGZyZWUgdG8g
cHV0IHRoZSBmdW5jdGlvbiBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGFuZCB3YWtlDQo+IGl0
IHVwIHRocm91Z2ggaG9zdCBpbml0aWF0ZWQgZnVuY3Rpb24gcmVzdW1lIHJpZ2h0Pw0KPiANCg0K
SSBtZWFuIGlmIHdlIHdhbnQgdG8gdGVsbCB0aGUgaG9zdCB0aGF0IGEgZmVhdHVyZSBjYW5ub3Qg
YmUgc2V0IG9yIHRoYXQNCml0IGRvZXNuJ3QgZXhpc3QsIHdlIHNob3VsZCByZXNwb25kIHdpdGgg
YSBwcm90b2NvbCBTVEFMTC4gSG93IHRoZSBob3N0DQpyZXNwb25kIHRvIHRoZSByZWplY3RlZCBT
ZXRGZWF0dXJlIHJlcXVlc3QgaXMgdXAgdG8gdGhlIGhvc3QuIEJ1dCB3ZQ0Kc2hvdWxkIGF0IGxl
YXN0IGxldCB0aGUgaG9zdCBrbm93IHRoYXQuDQoNCkknbSBzdWdnZXN0aW5nIHRvIHJlbW92ZSB0
aGUgc2V0dGluZyBvZiB2YWx1ZSA9IDAgaW4gY29tcG9zaXRlLmM6DQoNCi0tIGEvZHJpdmVycy91
c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRl
LmMNCkBAIC0yMDAwLDcgKzIwMDAsNiBAQCBjb21wb3NpdGVfc2V0dXAoc3RydWN0IHVzYl9nYWRn
ZXQgKmdhZGdldCwgY29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybCkNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRVJST1IoY2RldiwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImZ1bmNfc3VzcGVuZCgpIHJldHVybmVkIGVycm9yICVkXG4iLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZSk7DQotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZhbHVlID0gMDsNCiAgICAgICAgICAgICAgICAgICAgICAg
IH0NCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICAgICAgICAgIH0NCg0K
DQppLmUuIHdlIHNob3VsZCBhbGxvdyB0aGUgcmV0dXJuIHZhbHVlIHRvIGdvIHRocm91Z2guDQoN
ClRoYW5rcywNClRoaW5o
