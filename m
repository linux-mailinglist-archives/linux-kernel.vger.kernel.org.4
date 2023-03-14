Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D496BA17D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCNVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCNVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:34:52 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608574FABE;
        Tue, 14 Mar 2023 14:34:51 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ELELnX018121;
        Tue, 14 Mar 2023 14:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=STU8RCNIUdH1FkVv+CViSt+mrXAC7c31FsCFrx4Ur8s=;
 b=UkX935QQymy29Y9QD+HEbJOWKof1rsgHG2e+tyPWXsgiBF6as/5jcIky7N2CK4B7nxTZ
 ADghG4838oEqyGZ1BPD62mHySb+fmk4VvZ0ILJyd76M68Dv0VB+XUCaxegJCB/3lQxT2
 l3DOXFMVzDFsWPw0B2GJLTw1U5b0m38+y4Mp04v8h7pWlOknK//RMtQT9PnVgrswW4Qg
 ZhV5Vb9B8vMEoxyqL9A9/HnQmd5ARGFhazzDvMNURmeD+CjwkInswKH3dCEKYayl0zG0
 FWoUeHCcsvCgM6lTyn2/Vb1I2EGu2GkI5EXvvY+8usg4+MfFyidxvYIFiXe5iDh2mfNs Wg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p9ar4cfjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 14:34:43 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 50C6B400D9;
        Tue, 14 Mar 2023 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678829683; bh=STU8RCNIUdH1FkVv+CViSt+mrXAC7c31FsCFrx4Ur8s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W6ckmZDg7agxRbQjWQtdo0F+5Rl8bxXXXHeUOVF4oG4bEJybst7rrxRCnzCysjP1A
         UOGZbrLuUZtSKnkdGk4aUOPr10DyLzMHvTzmMxyTHvxJjvE7GlGyc631SoBhnU+YEo
         GhKZaYEEXSXT8N+HTL46dini9FDw1HfKFwZNsTSNz2s5PDqTnJxCMUU1KF0hZ3id1N
         o27k5NlUtmPhEA8dpoOnBPe0LgRblGS8nToQm0lvVeotCFeXwMc6U2T0crBbZyBKB8
         tN6zpkfYqptBWy5mO+/ajZ0LOZOeh3ceQaG8qQmIEyWyCAvf+Nrn0PVEs/g9uz6/Zy
         1FKp/WlH68yFA==
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C2E9BA0079;
        Tue, 14 Mar 2023 21:34:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=htsKZJHl;
        dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B5A492286A1;
        Tue, 14 Mar 2023 21:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGPUcklfUJ9qemB9VjMeAwCcF22ftejSSfiZBQl819Yh6riRTPJq04Ky1aDhmxkhGMFoxULIayCxmKpmybxTWLQdRnWbA8JLAAKyg7IfoEqIkYhj3ctk1C2ltr6l2K0lelLWRyrgWnZdWYG5NI4ppVSIFI0CUUE3L8gfHA0PQPOrt7sLx0ClTXz3hlrgxDV0o8uLjJdIsyOuoWsC8wGPUTv/y3Z2pCA+IUyIbPCwbCHtaWciCZtUdR0rDJMFV4QR77VLJZaqZqDYwiSTeTxYjnTrw+SEUv9hxw5rdpK3cNb2SMSdbCdpxt1yaxiQn343Ac/RI99dtJvOQMN1dL+t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STU8RCNIUdH1FkVv+CViSt+mrXAC7c31FsCFrx4Ur8s=;
 b=SNUwVBPaBeKOlKFWQ6tLVuMKY4YFy0AhzKLcIQ4E76O+ezva4bM4WaYogSdwpN6Hfe/a5ViU5dFOnNuA9Xk+0ChWnUz7Nas62SRSi6e2kNwBdsGzmCwk2g2YJxbht5TXsBqAVwzToFJdkmKBxr1mQq3mt4b0Vr2TrD5KSgl61Epj2IXMRd4dSgK/UcQYDMpS2P6+boXYoI7UsocVyK4PdHZRjtYzTznqUB3MuYY4YRwkLYwJkW7WYBIwoQqtEBSwjSxMucNhAFri30JSh3vaf09j6QV1scSKwjzQWxsonQcYLTBH33DYLRggel/XBIBGDy2pv+VZWmGJ/JmPFKuXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STU8RCNIUdH1FkVv+CViSt+mrXAC7c31FsCFrx4Ur8s=;
 b=htsKZJHl1995oiodw7aPS91h4QMuoUkr1N91ZCAKs1DF/OzzQBAlH8gOCCihJ2JCK1hhFVPmz871GJISWhhuELXXunDzmojdI77+vFbR40Cu9In53lRzADizLBe2MJycfF9y4ZtwpNTd9TGo+bRJ0xNepvoM6k/ofqE5vdt9Ycc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 21:34:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 21:34:38 +0000
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
Thread-Index: AQHZVdkm2qliMtpSnkaUilVaMBFAZa75KJuAgAGELgCAAAtFAIAAB/sAgAAFFgCAAAi7gA==
Date:   Tue, 14 Mar 2023 21:34:37 +0000
Message-ID: <20230314213437.7bnj2xw6wjvl7dp6@synopsys.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
 <20230313202655.srqfddpn5r36zt3o@synopsys.com>
 <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
 <20230314201636.mfmjrgluckyk5xhy@synopsys.com>
 <20230314204510.4n72sdm2xk3viy3e@synopsys.com>
 <c90f9af3-5e1c-c249-6dac-1387511f4fdf@quicinc.com>
In-Reply-To: <c90f9af3-5e1c-c249-6dac-1387511f4fdf@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB5956:EE_
x-ms-office365-filtering-correlation-id: 597b8f31-e5d5-467e-7e8c-08db24d3e9a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHlUKu7kiCWx5lYQmeSaLbPj4NiFuqaOci+/dHsuDY1vo1UKsV3KhdQp5wYKH4rdMUfM6QCbJticfwzFYQf9cUqhROrbW2N0Rx2a+cEAhEwY2/mRmGcGsuZqrAY9x28V8RLSw60pP4+YZBfa/a/jc/0PNaiTIabjEZf/76d+ZaVDp5TQJv1jZRdLSbsy/TE+1C/3W7Fqh/k2lucLunslfEYLUINU7ErRU6KavKqofZJtZlg4HmBPg4z9O3aVk3JypGyg6kEDTfMoskzNq650Vs8y2vgxCe3Imr1lyk5KuahHJkEse99Ye3d06sykrgYQOCKLjJ2CNKUQCFlafRHgCqqOMszSJ8c4cBDI0ri84ofCHORpjZuyLRFXCutwGz4y1+hAl0BZacjeQ3p/WXjV3ogXi+Sw1EmoJEPbAgTHEd4NW2691gOs9LqCnkmKL0oOpXHCk2zctOo6iIjT+AauK8WHHD9tbn8/hK5/YLnwsFMEJrcLyn42FpLLspQtITo79JHSWyOoGLiQY0mTe+xLSJQ5JIiV5DDBUb1duTraQuOX8rsKHTTRhTeKmBIjEOaOemEOKkRRb2bRYBOamtN+2Grtd15yFrhOfJUnF0zDM1s/Xr99XHVk9m3xL8A0K3eCLBOwNMISZNch4aKgY5VvtO8DnPPUw3DyI6mKba5cx59uag2xUXAKEFzzd6YQiWCiGhHDA9YBtuwSbDISwPyhqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(38070700005)(86362001)(122000001)(38100700002)(36756003)(54906003)(8676002)(4326008)(76116006)(66476007)(8936002)(6916009)(66556008)(64756008)(66946007)(41300700001)(66446008)(478600001)(6506007)(316002)(2906002)(5660300002)(15650500001)(2616005)(83380400001)(71200400001)(186003)(26005)(6512007)(53546011)(1076003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlhtUlNqMkZVOTV4eHd2RTh2S3N4dCswUzRTVFhUR09sbXdLRThZVzJHdEth?=
 =?utf-8?B?UUEwWDdFRnlGTFdWR29MaWoyQ0U5cmxYYWVxSjNFRWxMcUVVdDhMd05YRFBm?=
 =?utf-8?B?eTlRZlRhZGcrTU8wUi9iUWRRQURBOWF3eVJPY1REeVpnRGZtaWdXNU9nNFN0?=
 =?utf-8?B?dzhrT3VsbWtsbDE5ZjRySlY2dEFpYVgrazVydG1BUnVWT1E3MGZyWEJJK1d6?=
 =?utf-8?B?aElNQTJUU3N1NUZmWjgxK2tkNG04UFk3QTAvVlk1dXN4SWNST0kvU2k4Vllv?=
 =?utf-8?B?QnVtcE9DZzE3aFNNSTZvbkZLSURhc2ZYV2NZekQ5SUFZZW9yUU1NRlFQWFVx?=
 =?utf-8?B?TWpoZjRRalVYdUZ6eUZKbzltSTM4akJwZTNiWnpSalpJOG05bWgwL1I3MEp0?=
 =?utf-8?B?cUMrS0l6ZHVCU1Jldy9aYTlOZkJ2RWV1NjZINDFsVGQ4dHJ1U0dKWkx1WlRH?=
 =?utf-8?B?V21TVUdJNVZJdDVIZnpkNGZ2MVd1SFZUWk1VaTZWOHVBQ1RSUUJhbHlUVjdz?=
 =?utf-8?B?K0Vxc2pXTHZKb2gwT3BqMWE3S3J3Q2x1Y042WEFPaU1VcGo3Y0JHUUpvM0lP?=
 =?utf-8?B?SFQ5TU1rTVkxSVlxZkx2ZGRqcXRUMVZyNVdHa2FWNWU2azRwUjZyYVNXb3hJ?=
 =?utf-8?B?RWRRcnlkdG9oNGU4TTNhcE9NQmNkQ01kenU0NVZVVGZxNzBqU2RIOFpSREsx?=
 =?utf-8?B?MlV1RVBUOThYemFGQ0xOSVNkLzJMZUkrSDAxU2dQWDBEOGg0dTJKR3RsbVAy?=
 =?utf-8?B?Wmp4Skl1TTY2WkxhQWJMTlYybHVuN0hHYkJUaFh4NUZpK0pGbWh0Ym9PeUtr?=
 =?utf-8?B?MTdRZ1dxWHJOSzA3UE5YdVFxVXZZcWRXb1I5cWVycHJXdXhuaXI5VklJOFI3?=
 =?utf-8?B?NXpGQ1FWblBJTENrY0x5V2ZpTHBMUXlkV3lGejd4N1VEdVlUTFBCejNGOUs0?=
 =?utf-8?B?QWdUeVRWaEVkS3NBRE1FSkUwTGhoR0JYSUhib2I2NC9BSmpzU0RQdkhObzZa?=
 =?utf-8?B?b1NZOFc3dlRmQlV5Nk9zemRDdUMwMXdtOEZFUnNKRDB3c21mMUVlQi9iamM1?=
 =?utf-8?B?V0lQZzF4SlJFbUs0Z1VVbVo5aXZIODhrclhxekhVVExZaXdzK1VYZngvejJn?=
 =?utf-8?B?WUJOVHcveFh6S0VxWWdaNmZlTDlYK1FtSzdMSGwwdWtZWnhkSVJqYVpURXNs?=
 =?utf-8?B?cFcxMnZLTWovM0NySkdTVkFUQXpJbEl4cHR6TWVLVFJ4c0ZjZ1FjbTJWYjcw?=
 =?utf-8?B?b1NnckRkWUNGa3Q0STNOYS9TMlREcjROVnlyU0ZzS2lYSTVaZHpZRHZrWmNU?=
 =?utf-8?B?SmZRQUtSbXpqT0ZxTTJ2ZXREMzZLOGNNclVGdWxBNE43bWNRcVNSZEIyLzU3?=
 =?utf-8?B?UWFaaHZuZ3ZCVXZiNi85b2VteHVlTjVzLzBrRjNDYVJXTVZOQ0VmK28rVkJJ?=
 =?utf-8?B?S1FoMzlXZ3VsZ3JjMzlTSXM4bm94Z0l0Tmk3YVlpU1NBY3JWVnoyRFp0andm?=
 =?utf-8?B?S2oycGRCb1g5L0JNb3I5dHp2QkVpUU9RTld4NDdZM0RrZHRadjZNck5wTU5a?=
 =?utf-8?B?SkhBMGpZRWkzcWh3Sk9YWGVzZDc4YTZGNGZKVHZkZHhDQks2NmRFSEovUURR?=
 =?utf-8?B?cExURUJYRFJmdVk2MUVEcVEwRmRrZXB4RnhSSVEyb09Qemt1cW5NUTcwMzJr?=
 =?utf-8?B?N3k0VDFUNVVGN1luOEhySlM5eU5pZW84RWZueDQxb01yMjRQUDIxRmkyUVMy?=
 =?utf-8?B?ZXFJRFlzTUxVaWg4OUxkb0llL3dWZnV5eWwxYStoT1YxNE44S2o2MmlhK29j?=
 =?utf-8?B?ak1QZ3ovZzlHb2dtQmgwYnBzcFVZNW5VSmU4OTRpOWc5d3NzVDJzWkQxUFpJ?=
 =?utf-8?B?T1ZIcTlIZUNBRTdrU0lxb25ibXlDZDBuQUhUMTNRMHRLQ1daclpZclJBdE92?=
 =?utf-8?B?S3ExWjZrQVhhUUgyaG5lOWw3Sk0xaWZwVGd5cWhLSUVaQlhMTXFLRXA4ZlFs?=
 =?utf-8?B?OFV6a1pWVEordExXV21KOGNvZjYxNmZmTnBCSDFaYytOUzQ1VUhuczk4UXk5?=
 =?utf-8?B?UjNHM3V2bkZWeGx5Y01MZEdabVViYXBFWXNJaVc5alBkMmFteVNQWmhIUm9K?=
 =?utf-8?B?ZWFmV0JQMHlkWnVjRlVMMDVFYkxURXFOa3pzK2RxSjUwdU5BUENuRTJMK2Y3?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8067C76279A1894DBC33A09FA74818CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WuUR8HEr5wpfNM9gCYjXKaUyY++3/aAqMO7WpVXCtM35dqmwmSh9oQ/exQR3eyQizPWOBfTiHbioKaR7giC1IrxpMXTuk6eWr8cKCBsgDKJh7Wn0XrtHHXhUVvA2ZYi5OmgzwaqSt/WxFhOv/4c0OXyrqRhE/zdX1dBbate2nHIGD7pHQaxxq07nd4jwwpAnNp+RXCjmdoMGbgHDa1aRlfzH10wUhwlXoga2SKMHt6So9Vg9ckg2sRAi2R9bh8yY9m2PwJQSDcZWmuDEmd/CqnfXEW82NZXUStN7p8TrHwNiGfhuNYpMb8xuSEomrRXdudq2sob36V7RMDQ95/VNPNHxONWyX18T9Xx6kSXaB6B5CQk0/0jiwoI7wJAL+qdKDRLSGdlR577b4nwbzTWwZkuyoFnYHvHr8SsoZ84vMGKbgBz/ROjvTDs9Ge1CiS4IJmHxB5EtGYP9a+8mtLa1owstyDoMACyNQA4oNdFL3ZBUUzQN7NtKcdIa9UF9HCYmzZbNYLc2VqEuOfl1Hfjmfzv+8dliEfZLCLKd6ltghMtY4kHjiPFflrhyGRIVcqdbsd8MJbYhNi+khX2/ZD/6JiwNtlm4r+SvtV2yKqguTJDqsnXaMHccugK7Vp8z7fdf2SpYrXO8YkqDfPo4KyCnWXErfQqWfLaKfApeEkSCRK2HuI9xc8Zs7fUB7Yh/1xV2xLAzMjiAVy0xi3hkbSUajeRJiUfb2fZOMtgsQtx2lWjXt1hvwUYRrQ6mHuqAk2ZCgBF26A9LhpC/lv1YMLTWdDwdIWlbKk7k/7/9UYE3YAD7LQsxBueAWPT8OZ1Hey10HkHu2uNRfzlQcR2O5fOwMJK7U2MKW9GX1lDYLNw5JLISDjEopI5d+LoUHljBs+NY8Up3FKhIKH9x1fV4cq0pQTbwHHAjWn9ybAFloQFMwvA=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597b8f31-e5d5-467e-7e8c-08db24d3e9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 21:34:37.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12Kq2xagEd5E6u4jWXBTLwatiyDVpfI0CmnloMha6xM9tzVDRiGpc2zj/S4Yfei8IU9Eym6vNO3bAuZv9Oy8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Proofpoint-GUID: 1oiwiJ9GPu-rvG5nlr9t_4xRCaO06Z8N
X-Proofpoint-ORIG-GUID: 1oiwiJ9GPu-rvG5nlr9t_4xRCaO06Z8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_14,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303140172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMTQsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzE0LzIwMjMgMTo0NSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWFyIDE0
LCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1hciAxNCwgMjAyMywg
RWxzb24gU2VycmFvIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDMvMTMv
MjAyMyAxOjI3IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBNYXIg
MTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gPiBXaGVuIGhvc3Qg
c2VuZHMgYSBzdXNwZW5kIG5vdGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlLCBoYW5kbGUNCj4gPiA+
ID4gPiA+IHRoZSBzdXNwZW5kIGNhbGxiYWNrcyBpbiB0aGUgZnVuY3Rpb24gZHJpdmVyLiBFbmhh
bmNlZCBzdXBlcg0KPiA+ID4gPiA+ID4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlv
biBzdXNwZW5kIGZlYXR1cmUgdG8gcHV0IHRoZQ0KPiA+ID4gPiA+ID4gZnVuY3Rpb24gaW4gc3Vz
cGVuZCBzdGF0ZS4gSGFuZGxlIGZ1bmN0aW9uIHN1c3BlbmQgY2FsbGJhY2suDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBjYXBhYmlsaXR5
IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiA+ID4gPiA+ID4gdHJpZ2dlciBhIHJlbW90ZSB3YWtl
dXAgb3Igd2FpdCBmb3IgdGhlIGhvc3QgaW5pdGlhdGVkIHJlc3VtZSB0bw0KPiA+ID4gPiA+ID4g
c3RhcnQgZGF0YSB0cmFuc2ZlciBhZ2Fpbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0K
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl9lY20uYyAgIHwgNjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiA+ID4gPiA+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2MyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gICAgZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuaCB8ICA0ICsrKw0KPiA+ID4gPiA+ID4gICAgMyBm
aWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiA+ID4gPiA+ID4gaW5kZXggYTdhYjMw
ZS4uZDUwYzFhNCAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX2VjbS5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl9lY20uYw0KPiA+ID4gPiA+ID4gQEAgLTYzMyw2ICs2MzMsOCBAQCBzdGF0aWMgdm9p
ZCBlY21fZGlzYWJsZShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gPiA+ID4gICAgCXVz
Yl9lcF9kaXNhYmxlKGVjbS0+bm90aWZ5KTsNCj4gPiA+ID4gPiA+ICAgIAllY20tPm5vdGlmeS0+
ZGVzYyA9IE5VTEw7DQo+ID4gPiA+ID4gPiArCWYtPmZ1bmNfc3VzcGVuZGVkID0gZmFsc2U7DQo+
ID4gPiA+ID4gPiArCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gZmFsc2U7DQo+ID4gPiA+ID4gPiAg
ICB9DQo+ID4gPiA+ID4gPiAgICAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0KPiA+ID4gPiA+ID4gQEAg
LTg4NSw2ICs4ODcsNjggQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb25faW5zdGFuY2UgKmVj
bV9hbGxvY19pbnN0KHZvaWQpDQo+ID4gPiA+ID4gPiAgICAJcmV0dXJuICZvcHRzLT5mdW5jX2lu
c3Q7DQo+ID4gPiA+ID4gPiAgICB9DQo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgZWNtX3N1c3Bl
bmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiAr
CXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+ID4gPiA+ID4gPiArCXN0cnVj
dCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKSB7DQo+
ID4gPiA+ID4gPiArCQlEQkcoY2RldiwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsN
Cj4gPiA+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gKwlEQkcoY2RldiwgIkVDTSBTdXNwZW5kXG4iKTsNCj4gPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiA+ICsJZ2V0aGVyX3N1c3BlbmQoJmVjbS0+cG9ydCk7DQo+ID4gPiA+ID4gPiAr
fQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3Ry
dWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiArCXN0cnVj
dCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCB1c2Jf
Y29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiA+ICsJICogSWYgdGhlIGZ1bmN0
aW9uIGlzIGluIFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ID4gPiA+
ID4gPiArCSAqIGNhbmNlbGVkLiBJbiB0aGlzIGNhc2UgcmVzdW1lIGlzIGRvbmUgYnkgYSBGdW5j
dGlvbiBSZXN1bWUgcmVxdWVzdC4NCj4gPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gPiArCWlm
IChmLT5mdW5jX3N1c3BlbmRlZCkNCj4gPiA+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJREJHKGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJZ2V0aGVyX3Jlc3VtZSgmZWNtLT5wb3J0KTsNCj4gPiA+ID4gPiA+
ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIGludCBlY21fZ2V0X3N0YXR1
cyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICsJ
cmV0dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlcgOiAw
KSB8DQo+ID4gPiA+ID4gPiArCQlVU0JfSU5UUkZfU1RBVF9GVU5DX1JXX0NBUDsNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBOZWVkIHRvIGNoZWNrIHRoZSB1c2IgY29uZmlndXJhdGlvbiBpcyBpZiBp
dCdzIHdha2V1cF9jYXBhYmxlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IGVjbV9mdW5jX3N1c3BlbmQoc3RydWN0IHVz
Yl9mdW5jdGlvbiAqZiwgdTggb3B0aW9ucykNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiAr
CXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+ID4gPiA+ID4gPiArCXN0cnVj
dCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJREJHKGNkZXYsICJmdW5jIHN1c3AgJXUgY21k
XG4iLCBvcHRpb25zKTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJZi0+ZnVuY193YWtl
dXBfYXJtZWQgPSAhIShvcHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfUlcgPj4gOCkp
Ow0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNhbWUgaGVyZS4gQ2hlY2sgY29uZmlnJ3MgYm1BdHRy
aWJ1dGVzIGlmIGl0J3MgcmVtb3RlIHdha2V1cCBjYXBhYmxlDQo+ID4gPiA+ID4gYmVmb3JlIGFy
bWluZyBmb3IgcmVtb3RlIHdha2V1cC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gRG9uZS4gSSB3aWxs
IGFkZCB0aGF0IGNoZWNrIGZvciBhYm92ZSB0d28gY2FzZXMuDQo+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiArCWlmIChvcHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkp
IHsNCj4gPiA+ID4gPiA+ICsJCWlmICghZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiA+ID4gPiA+
ICsJCQllY21fc3VzcGVuZChmKTsNCj4gPiA+ID4gPiA+ICsJCQlmLT5mdW5jX3N1c3BlbmRlZCA9
IHRydWU7DQo+ID4gPiA+ID4gPiArCQl9DQo+ID4gPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+
ID4gPiArCQlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiA+ID4gPiA+ICsJCQlmLT5mdW5j
X3N1c3BlbmRlZCA9IGZhbHNlOw0KPiA+ID4gPiA+ID4gKwkJCWVjbV9yZXN1bWUoZik7DQo+ID4g
PiA+ID4gPiArCQl9DQo+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ICsJcmV0dXJuIDA7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTmVlZCB0byByZXR1cm4gbmVnYXRp
dmUgZXJyb3IgaWYgU2V0RmVhdHVyZSBmYWlscy4gV2Ugc2hvdWxkIGZpeCB0aGUNCj4gPiA+ID4g
PiBjb21wb3NpdGUgbGF5ZXIgdG8gYWxsb3cgZm9yIHByb3RvY2FsIFNUQUxMIGhlcmUuIEhvc3Qg
bmVlZHMgdG8ga25vdyBpZg0KPiA+ID4gPiA+IGl0IHNob3VsZCBwcm9jZWVkIHRvIHB1dCB0aGUg
ZnVuY3Rpb24gaW4gc3VzcGVuZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MsDQo+ID4g
PiA+ID4gVGhpbmgNCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IENvdWxkIHlvdSBwbGVh
c2UgY2xhcmlmeSB3aGF0IFNldEZlYXR1cmUgZmFpbCBoZXJlIG1lYW5zPyBUaGUgaG9zdCBwdXRz
IHRoZQ0KPiA+ID4gPiBmdW5jdGlvbiBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIHRocm91Z2gg
dGhpcyBTZXRGZWF0dXJlIHJlcXVlc3QuDQo+ID4gPiA+IElmIHRoZSBkZXZpY2UgaXMgbm90IGNv
bmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAgKGJtQXRycmlidXRlcyB3YWtldXAgYml0KSwNCj4g
PiA+ID4gbGlrZSB5b3UgbWVudGlvbmVkIGFib3ZlIHdlIHNob3VsZCBub3QgYXJtIHRoZSBmdW5j
dGlvbiBmb3IgcmVtb3RlIHdha2V1cC4NCj4gPiA+ID4gQnV0IHRoZSBob3N0IGlzIGZyZWUgdG8g
cHV0IHRoZSBmdW5jdGlvbiBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGFuZCB3YWtlDQo+ID4g
PiA+IGl0IHVwIHRocm91Z2ggaG9zdCBpbml0aWF0ZWQgZnVuY3Rpb24gcmVzdW1lIHJpZ2h0Pw0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBtZWFuIGlmIHdlIHdhbnQgdG8gdGVsbCB0aGUgaG9z
dCB0aGF0IGEgZmVhdHVyZSBjYW5ub3QgYmUgc2V0IG9yIHRoYXQNCj4gPiA+IGl0IGRvZXNuJ3Qg
ZXhpc3QsIHdlIHNob3VsZCByZXNwb25kIHdpdGggYSBwcm90b2NvbCBTVEFMTC4gSG93IHRoZSBo
b3N0DQo+ID4gPiByZXNwb25kIHRvIHRoZSByZWplY3RlZCBTZXRGZWF0dXJlIHJlcXVlc3QgaXMg
dXAgdG8gdGhlIGhvc3QuIEJ1dCB3ZQ0KPiA+ID4gc2hvdWxkIGF0IGxlYXN0IGxldCB0aGUgaG9z
dCBrbm93IHRoYXQuDQo+ID4gPiANCj4gPiA+IEknbSBzdWdnZXN0aW5nIHRvIHJlbW92ZSB0aGUg
c2V0dGluZyBvZiB2YWx1ZSA9IDAgaW4gY29tcG9zaXRlLmM6DQo+ID4gPiANCj4gPiA+IC0tIGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvY29tcG9zaXRlLmMNCj4gPiA+IEBAIC0yMDAwLDcgKzIwMDAsNiBAQCBjb21wb3NpdGVf
c2V0dXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwgY29uc3Qgc3RydWN0IHVzYl9jdHJscmVx
dWVzdCAqY3RybCkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVSUk9S
KGNkZXYsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZnVu
Y19zdXNwZW5kKCkgcmV0dXJuZWQgZXJyb3IgJWRcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZSk7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZhbHVlID0gMDsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB9
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiAgICAgICAgICAg
ICAgICAgIH0NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBpLmUuIHdlIHNob3VsZCBhbGxvdyB0aGUg
cmV0dXJuIHZhbHVlIHRvIGdvIHRocm91Z2guDQo+ID4gPiANCj4gPiANCj4gPiBBbHNvLCBJIGlt
YWdpbmUgdGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIGRvbid0IHdhbnQgdGhlIGhvc3QgdG8gcHV0
IHRoZQ0KPiA+IGRldmljZSBpbiBzdXNwZW5kIGJlY2F1c2UgaXQgbGFja3MgcmVtb3RlIHdha2V1
cC4gZS5nLiBhIEhJRCBkZXZpY2Ugc3VjaA0KPiA+IGFzIGEga2V5Ym9hcmQgKHRob3VnaCBpdCdz
IGEgYml0IG9kZCB0byBzZWUgb25lIHdpdGhvdXQgcmVtb3RlIHdha2UNCj4gPiBjYXBhYmlsaXR5
KQ0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiANCj4gU291bmQgZ29vZC4gSSB3aWxs
IG1ha2UgdGhhdCBjaGFuZ2UuIFdvdWxkIHlvdSBwcmVmZXIgdGhpcyBjaGFuZ2UgKGkuZQ0KPiBy
ZW1vdmluZyB2YWx1ZSA9IDAgIGluIGNvbXBvc2l0ZS5jKSB0byBiZSBwYXJ0IG9mIHRoaXMgc2Vy
aWVzIE9SIHNob3VsZCBJDQo+IHVwbG9hZCBhIHNlcGFyYXRlIGNoYW5nZSBmb3IgdGhpcz8NCj4g
DQoNClRoYXQgY2hhbmdlIGNhbiBiZSBzZXBhcmF0ZWQgZnJvbSB0aGlzIHNlcmllcy4gTGV0J3Mg
dHJ5IHRvIGdldCB0aGlzDQpzZXJpZXMgaW4gbWVyZ2VkLg0KDQpUaGFua3MsDQpUaGluaA==
