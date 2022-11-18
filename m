Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2862EA73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiKRAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKRAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:40:55 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48B74ABF;
        Thu, 17 Nov 2022 16:40:55 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHNRAWu030261;
        Thu, 17 Nov 2022 16:40:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mBppDeFv43rGgebQLi+aUnG4ZWRXghgM4CN2A6xiWIo=;
 b=oBdDdtvSfrqTkMOtAj5dVnGtG6cWoiC6lCgDI7V/xqz4bqJuyb2/s4Nvpo0SeprrYYW9
 P95m9AlxAUXGtwM9QtkxvKvCGJBPWYOBqt/RZABUBq9b1lUEY5+6V8vOJ8sF2sULY/OQ
 CSoCFUrfs8YAbtthydni4RGzDBXfw06NqJYJhLfiuB9RyjO4/ZCKIvsa1jW7XDsSoHAV
 yi93U4C2UaHUEQqbCmODcAKkZPiLWzGiVzBVCVvFi+mXWfqypYHPoiArWneX9oNR6fVR
 bf/XVTF4RbJYUEbqSR9Qcr8JMiR+l0bFMrHWE42LP1n4FR7KJKcAPnRJ1Vkr2Iu98L3f TQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kwxn2r7t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 16:40:54 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0465DC07FF;
        Fri, 18 Nov 2022 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1668732054; bh=mBppDeFv43rGgebQLi+aUnG4ZWRXghgM4CN2A6xiWIo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VhqlBzo6IYXElnJThIkKNf1008x+CGIcb46ADFKIfXQbqEIY941Gv+vj5JlWjDPqP
         aElrZtgjIwFS/YfVpbrykOKJDpHtPFCazEGXwlUhdaM53ShxiRSvbOow490NXoWXDY
         kNaRNOZLLaix0gFYKvAkQg1s58+a9lO8yNDANocDRyoJsG9tJGrGw2hE6JqOtT1TmJ
         DqJ4SdJVMdYN6KFc/jD1Qgg8e1DzwtuC6MfebEOUsZN/Z3BOcJWGeLx+av22RuTbyQ
         X5PlX5u5D2dU/7+1Ib3aDUthTaNAvon6yQZmGufzNEtDcSI0KXdbXtJH9NzvOcFkIA
         kW9EhkuSdzNMQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 47640A0091;
        Fri, 18 Nov 2022 00:40:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 03DE4802B0;
        Fri, 18 Nov 2022 00:40:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ILSDrHiI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuzmiNGeHQuvM9jqJzX/dZDExoBF4RC2r7MxwzLysGxr/mEuLvCKmkdKaW/X8LdqYemJT2qBkUVnP7CE2jVc4e30NbCyhUiPKKDy928fMBefJQHoSg7x23LJ9xdvUe7/ZzNgJqvb0bhkExZ3x/lhU97pzYpovvJlRT39E4dMwv0ppuNM26inj/+ypSjTBpHfSUNWpaZyglJbc5VxROd36DrNh7iZp4a4SEmql1boUx47XEUVntu1MDA93vL2+f+9K7HT44XVMu1YLAQAMIcQ7zYyyZl4obWEAYMveDpVognr+JqQnI4U8fmfKLmdtspcf5oekUgg7W/t8Groao93ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBppDeFv43rGgebQLi+aUnG4ZWRXghgM4CN2A6xiWIo=;
 b=lH6fFutUkXj3OET4KorShU+6inSJoKgkByzeH1RvkL8v6G9KDnabVfQv5tU/XAgnuacgdD/Faw/cR/FxL5GnA/7o9jdxE1OfOyitow0nnHkqVnPgZrJoI9NwbTh+S+nQwyfOmeEDYZWzL9v2E5nzQMR2inG0wHypWX8n7plL0ov+KVNf26WJJ2Ojq6Ny4XrMphDemQbscafdoGY8RfqiLZaXfsT1WuKrzw+ylqRsUWT/Tj7GeTC6MKEjY+pxT2Ik0Oa7Kq0yi1VP5IdscunZIdWeMkYxuvsiYbw0Zniorpiix5ZZzYyIubbxlzh+FcYd1z6MFCO84bVHmvXTVhP/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBppDeFv43rGgebQLi+aUnG4ZWRXghgM4CN2A6xiWIo=;
 b=ILSDrHiIPy1bK0nH2kMi7Tyj6hf6VUptd00J4Z2NlrpVEivEAtSVENNa56xcn8e1iWaau7gMRZ3fAhF+LmLi2JuvI3UM+JkalXkXi0gkBV/bRXiAuBOjyxM7Csj7QH70Dy5/o4S95G3kSczrYgzvS8c8njDX4XzwllUBVKeGCZo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 00:40:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 00:40:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "guo.ziliang@zte.com.cn" <guo.ziliang@zte.com.cn>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next] usb: dwc3: gadget: remove redundant ret
 variable in dwc3_gadget_vbus_draw
Thread-Topic: [PATCH linux-next] usb: dwc3: gadget: remove redundant ret
 variable in dwc3_gadget_vbus_draw
Thread-Index: AQHY+idu/SJfS2G31EmHKy1aXFG6Eq5D2HAA
Date:   Fri, 18 Nov 2022 00:40:46 +0000
Message-ID: <20221118004036.6r6knkmag6ghbeud@synopsys.com>
References: <202211170953310238773@zte.com.cn>
In-Reply-To: <202211170953310238773@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH8PR12MB6817:EE_
x-ms-office365-filtering-correlation-id: 6bef34e1-dd8b-46cb-9f80-08dac8fd888e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLE1/T5SbCKzNLPwyjqru22ZCRtfcX+2rtX/mMQFZ5G2n7drx12GIZSflijjYvV4NZ5kpGgRFz0Ym/eFeQ6eFjT+2wx8EZmgIAzczLq7+LVVSg7bc0nYX8g3za1NVpEbSvnba9gMR0/NCGvEJKj40T7nUTEwz7A1S33FpI5XuYmR0tH3Gq/wjo2cH1RS9ylTDudyWG8DamePor24UIzWoelCAneVYhGOvXDy6zYlFrTaxC2XsTNxmeRLHHjbEoKxmNvv4vQB2OO32KIteTDd6ahSGit1WwRz1NwiJ8LxqSdjxJpK5xQi44eYwKadxu8IrFJnypIabiFYClAeW1UlK51kIYUCAE09XvJut7SDSv4LbRnL39wvZpPaVqlYPjCFz0wrHfAzu8P6aKsBAmOssykfCUotvKEm97qtbb926sLBVZaYnRXDpqFvjDyx8lWnykmit45mDjKEZYnPbgx0nQVk0k0Ezsw98JXEt6uui23Kbm74BLwt0oBl9EWoGzBe+3JwKhYJcSxkSRuM0sDhhagD0jJ+ZUGJYnLeEW4+bBamJ8uFmC8m5qZk37NfnBT5VpSyl+k/fJysAIFhlky/0lEuU0RNdrAmAO7fRPHF8P818l3yK0F9hZHwRtqOqd9ENqhsOpQ3IKGQTkQ4tZhPi2rGCqE85QASVnI1E+ZZ2MIOh5s0f17bBMCR0eJP8aVp8d5t0OcJUcpM9VCFUVhLEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(2906002)(8936002)(5660300002)(122000001)(66556008)(64756008)(4326008)(66446008)(66476007)(66946007)(86362001)(76116006)(83380400001)(8676002)(41300700001)(36756003)(316002)(38070700005)(54906003)(1076003)(6486002)(71200400001)(6916009)(186003)(6512007)(2616005)(38100700002)(26005)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNYd243MEJsZTFEL3A5T1FNSXlWVXRmR09uWFFwSEdYbWtvTk1MWWhBNXBk?=
 =?utf-8?B?UlRJY2pQbjZwdTJ2MkliaXpRTFhhdWlBeFM1R2NXV2x0Zmd2cGJXWUNUT3Z6?=
 =?utf-8?B?dzRQU0JlaVZ0Z3d2M3hzamZ1WGpvUEZlRTAvOElILzFtYUcyM0thdmMzYnha?=
 =?utf-8?B?UHhYRk5WNmV6UVdHdVRReHlXckFwU1gwYUFZcGVMeHdyVWZZd1BsN2pGSjd5?=
 =?utf-8?B?d0dlb3N1NDhBTjFNMmZvcFU2K0pTNXJlM1VYaWpTcENvTm9wbEpOcHJzTWFE?=
 =?utf-8?B?T1RXc0VHcjRBWUJZa01nZytGSHcyOXpldEdiVGRQUStXN1NnSnlNTnJMRUE1?=
 =?utf-8?B?NWIwTEExcFZ0SGNZcWJJa1pBU0tLeklhVHMxcWg5TkJ4VlNZNE51QWwxZGd2?=
 =?utf-8?B?T3VrTlkvZUoySGxyZmlwY2lxL3NYdGE4ZVRPbGR2ZmxIR3lPekx2Z0xWcmky?=
 =?utf-8?B?alUxL3BvTm9pNk9qcytjbDM5aXp5dGVlTWJQY3ltQ3laSTZnejlLYWFxMDRH?=
 =?utf-8?B?SnZrU1lRalJJdWk3RXNMc2tUdWlLU0VPMUQzQ2lwcUJyWGREVDlVTit1Q2t0?=
 =?utf-8?B?aDZUbGdUUGFtQ1R5OG9jeGlXcG0xcUJTYTNDN1ZwTWtjalE4N2U5QklzdXFV?=
 =?utf-8?B?dVdhbHNHbWFybTh6RHQ2eVFJbzhSbm5ySzE0cGs2Nm9jZUNjWGVvYXlrTTVQ?=
 =?utf-8?B?VFdob0g3RDhoMTJoN2g0eTRYRmtaUnh6L1BMMFYwSWhFY2RvSlF0RHlVN1Zt?=
 =?utf-8?B?UThGMG54RjZkc3FXa1pvMlFDekROdkxRVU1sVW9DVVNGZUM3RFBWb3RHZmhF?=
 =?utf-8?B?aHl2VkpSb1RKbW8yRTU2VDNHdWVwMzZ3Q005WDc0a0g1QW9qR1RJNEVjc1NB?=
 =?utf-8?B?R0RPdUJLQjVhYklaa0xBRklEWWZIUUp0V1lvTzJENUJsWkhXblBBVThEc2du?=
 =?utf-8?B?aEVDU001VkxST2RTRjhFZXRNUmdsY2dyem81V1VRSDNVbDdXREhUOFJsT2sy?=
 =?utf-8?B?TTdXS1FTOEJvNnpocWRETHFyc2ZsSElqUVF0T1dmWWs5cjBzQ3h1YWlMQVdz?=
 =?utf-8?B?cDAyNDhZQjVLTjkxam55REFwQTZOd29uZnZaVW9WakZrWWNscnpTTHRCV2ZO?=
 =?utf-8?B?VC9qOWdxMTREYm9HWWJta1F4RTJIUC9ReGJqR21WUFNMQVY0SllFWVp4bXJy?=
 =?utf-8?B?bkFTY1V5R0xKb3JBS0RvZGVPdTBPcEdDQkxhSU9Mb1I0cjIralN2ZXAvRFFz?=
 =?utf-8?B?OXZFSUVoaTVFM3lZaGxSV2hQWnRUL1RldWJ3bUwwTGNvVTI3YjVWbkFUVHRP?=
 =?utf-8?B?OTRMb0lxSXMrZ25WZy9XSG8xZmRBS21IeXJGcC9YVW9DMm0ydXlMKzFPODg1?=
 =?utf-8?B?UTNtZ0lHWVkyZ05DT3NhN2JkeVZkeERyajU2ZUppSWhtWVV2K2hoN2Z4ZjJM?=
 =?utf-8?B?bkRGOFErTjVaQXNFT2ZGaVM4RmpZTUp1T1oxdzhZYmpHZllkWVJoOEhZN1ow?=
 =?utf-8?B?TUlkUVJjNnpLc0pPMCtLTUlkY2lSTGxXUlEzS1YwajZpN2dBNDJtN0NLMFZl?=
 =?utf-8?B?QnB6V0xweDJYSlZHc2NJUm5ZRXl3ZFV3UWJXRFVCWm9RbWkxMVRQOWx2WWlF?=
 =?utf-8?B?Q3E1Qk0weGw1a0V2RENNejlsVGRhNHVmSkJPUTdkZW5pU29VMVNyVXY0SEZr?=
 =?utf-8?B?WCtGejYwU25oV0IyN3NmWEp3M0UxbVYyOTR1YUtYd1ZORnBZeU9hQzJKN1Nv?=
 =?utf-8?B?MEFFd0ZtdkZ6UGxFWmE5bEEvb2RLNWxXYW5rQXFpZjVTN3NhN2ZGWUUwOHV3?=
 =?utf-8?B?NFNlQUprNGQ1a1hpNmprVFIrYlgwanJIeURwelM3OHI0WUlOQ3l1TGVUenJG?=
 =?utf-8?B?dHU1ZXlJVkVaZUtlMThBdzR4RVlCNXl4eHFRTjdYWkZBV0xZZGp3R3lKai9F?=
 =?utf-8?B?ejhOTXg5aXVTR0gxN0lTUUlLWFFIQ0FxTGdMeEM1SEUyRGl3ckFzVTMzNlJo?=
 =?utf-8?B?MTQwa1FZaVl6SC9zdGhqenJuUDZnSzFxc0M4cWE3WXFFR05VZ0lVd2huUVJ5?=
 =?utf-8?B?eVdqTEpCOVFGVFFIa1RZaGlrRGF5M1RLTG92UXJuL05MMk40Qk9HN2lWWnZR?=
 =?utf-8?Q?t+NixwrpZA53zkkPWeSVUD03F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D81DFC42BCCABC47888C10928EFD8402@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V44OWYNZSUlSMLt1itBZDgIxqHBNkKFDM2v0mNrZrGiRz1nQkf4gHP/zwh07U8fJOIwKAJyDDXYWaP2UtrwhFrvbOPB9OLLiNkrAE9GDfixG7uuTRZQJ/l/pH4Vpu86Bl1z8Mx7GqqQCImSzNCZDUreDJPmQBD6PA++L3UpHkXm6DKJkHqAZSszLRL8MxDLLqfduN//dtT8gbkAgHN9zfwrpZ9sHo9/yIBX0dyopG7iwtG5L3rmDP6lKrMX2JVpWyWWdIU2XHrpvodJhpc+iOdqINbKsVQ0v/Wfu/JNBKMJ9z9SB4iylFPcdsZX3PHwO4wFctaXTMKYoPGfMxj1mi85A7+TdgkRJJBAEdPJoJGEefTEuJkJcBwvflrivLNOVd4YbTGLHHsbXQMeL6tmZ25sBn6VIoBN3oUmvxSYOJqZYaAXw2EHMZ36XX0ASGR+mLSvQ8YVoY9yBIK6k+DWgs4QKgMUkspDixtv3Ui00vm4l59VcoSAVyKI+OHwxKGHrfNl3ShC8AkkfWZGBCE0zhx0C5eTdpK/57Lf+xYhubRtd0/lTHwgQ7H9mHjyXtFM6tQjf2Sp/MowzD5Et3NK43XxvU5IozdNF2wJVvmqwDjslQIYqRfDf2b8LUjZjBCycSJRMOcVbpa2T4C1Dcra9O2sbuzjGmvfSZ73H7L6zhCkdk4Gip/vd7mA6nV07XFnwhVB1kt/UNJSnbpiO/a2sMPZ75ZgUZ3ESo8xCOxMQ1IrvTRopOxqJZmC/JYvXreA48rtJEzjqv2WMNCwxxnPWydy6h8c+nMoVpe0CiJkhaiZ7+s0jg+aaeHBEN1Ivp79dOVxXQTNAuvLIzfMDvByJlKwE2eUZp0iSBXUe3ycYyS9DpIrJniRgjs9rM4H4B48o
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bef34e1-dd8b-46cb-9f80-08dac8fd888e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 00:40:46.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PyOtqqPJmqiIyGNFWuxGEjNGFTHKUegp91RVRVdfiLaelrOwY1VkN40bBuxyMFdzyWAkyRQBjj7dfhkLeIeJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
X-Proofpoint-GUID: Me2fYavACd2f4uPgZIRxk-0vp5Za8M08
X-Proofpoint-ORIG-GUID: Me2fYavACd2f4uPgZIRxk-0vp5Za8M08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 mlxlogscore=891 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211180000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMTcsIDIwMjIsIGd1by56aWxpYW5nQHp0ZS5jb20uY24gd3JvdGU6DQo+IEZy
b206IGd1byB6aWxpYW5nIDxndW8uemlsaWFuZ0B6dGUuY29tLmNuPg0KDQpBZGQgbmV3IGxpbmUg
aGVyZS4NCg0KPiBSZXR1cm4gdmFsdWUgZnJvbSBkd2MzX2dhZGdldF92YnVzX2RyYXcoKSBkaXJl
Y3RseSBpbnN0ZWFkIG9mIHRha2luZw0KPiB0aGlzIGluIGFub3RoZXIgcmVkdW5kYW50IHZhcmlh
YmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogZ3VvIHppbGlhbmcgPGd1by56aWxpYW5nQHp0ZS5j
b20uY24+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKy0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBpbmRleCBmYWYzN2M2Li5kOTg0ZDY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
QEAgLTI5MDQsNyArMjkwNCw2IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfdmJ1c19kcmF3KHN0
cnVjdCB1c2JfZ2FkZ2V0ICpnLCB1bnNpZ25lZCBpbnQgbUEpDQo+ICB7DQo+ICAgICAgICAgc3Ry
dWN0IGR3YzMgICAgICAgICAgICAgKmR3YyA9IGdhZGdldF90b19kd2MoZyk7DQo+ICAgICAgICAg
dW5pb24gcG93ZXJfc3VwcGx5X3Byb3B2YWwgICAgICB2YWwgPSB7MH07DQo+IC0gICAgICAgaW50
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQ7DQo+IA0KPiAgICAgICAgIGlmIChkd2Mt
PnVzYjJfcGh5KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHVzYl9waHlfc2V0X3Bvd2VyKGR3
Yy0+dXNiMl9waHksIG1BKTsNCj4gQEAgLTI5MTMsOSArMjkxMiw3IEBAIHN0YXRpYyBpbnQgZHdj
M19nYWRnZXRfdmJ1c19kcmF3KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCB1bnNpZ25lZCBpbnQgbUEp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+IA0KPiAgICAgICAgIHZh
bC5pbnR2YWwgPSAxMDAwICogbUE7DQo+IC0gICAgICAgcmV0ID0gcG93ZXJfc3VwcGx5X3NldF9w
cm9wZXJ0eShkd2MtPnVzYl9wc3ksIFBPV0VSX1NVUFBMWV9QUk9QX0lOUFVUX0NVUlJFTlRfTElN
SVQsICZ2YWwpOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICByZXR1cm4g
cG93ZXJfc3VwcGx5X3NldF9wcm9wZXJ0eShkd2MtPnVzYl9wc3ksIFBPV0VSX1NVUFBMWV9QUk9Q
X0lOUFVUX0NVUlJFTlRfTElNSVQsICZ2YWwpOw0KPiAgfQ0KPiANCj4gIC8qKg0KPiAtLQ0KPiAx
LjguMy4xDQoNCkxvb2tzIGxpa2UgdGhlIHBhdGNoIGlzIGNvcnJ1cHRlZC4NCg0KUmVnYXJkbGVz
cywgSSB0aGluayBpdCdzIGZpbmUgYXMgaXMgd2l0aG91dCB0aGlzIGNoYW5nZS4NCg0KQlIsDQpU
aGluaA==
