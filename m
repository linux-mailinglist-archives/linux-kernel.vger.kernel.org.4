Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A7697343
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjBOBLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjBOBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:11:51 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623D32CD6;
        Tue, 14 Feb 2023 17:11:27 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENix1n028676;
        Tue, 14 Feb 2023 17:10:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tlRDtpxKBsyL5JgklaN26xV3p8ZMAW3isjqj+n3D/ng=;
 b=LYivJz6YaWnFTHAs9I5Qtt0z1aY51vImqvfvI0/VKLsc6DqUAYm6jn27HdxrgbpnIGW9
 ReUqRMvnlM8biR0OvfTd+u6wL5PgZzXuXQ0Sr5lz+R0WW1epN9cx+8v+HIw82l/tU9PF
 MteF+qe2/R4ksjN82vn9BIyWSgBDJvL8Ve8PlkBlIFmAiX9e9AdRN/T1TXFFTLS/yu29
 5FQ5rNDxOuW4lQDs+qxMtHt8di+2g026GJH43dzdTFP2pfAu9JDeg2+Wfqq1tXB8AnR/
 05b5jbpb/lGS8QzVGUQ+HUTE5teYJhw9CWQrca7/9u5gb42DIpa33mqH/OSQYsuarrsj CQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3npb5c4ffq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:10:02 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A395EC0100;
        Wed, 15 Feb 2023 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676423402; bh=tlRDtpxKBsyL5JgklaN26xV3p8ZMAW3isjqj+n3D/ng=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kip7JV1FxNP+JnFsdm1KD9UuqVZflzUr/qLuRT08F9hleUTqg783GU8GTc3O9Vtfv
         E7gvXW4hahiN1uvzWtB+PNI/UtIMrcjHZ364AeaWg70bYcOEZiZpDNtKMK13Jm2Ic0
         Wwk89HsgI2ZFbYlBEFIaEVY5A87X8fFawT+FXAbGom3146mAO+jkeq9mfW/tBOMe7r
         pVxvPkHrhPKA28iYnXi5TbRgjZ6YL0U5vLa4GUUb1dFGTYbF+WB7Tr2iSlZ5VZQwHF
         XMsLbWWyJoFdiN7ovPXL3HMULULpNLl2MfnufNSLgRmJnvYQQQ3bxIKU7no8ZX0dAr
         wiveoDjjQMHEA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BCB0EA0079;
        Wed, 15 Feb 2023 01:10:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E72AE8007A;
        Wed, 15 Feb 2023 01:09:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JuYMw7uo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqfULksKgyvUYwiP9/1BD1zLx3g0i1L5wRnUrKmqYvzXUSQDj04tMIQ72pGtbkUZh83SJJiKOsmctb4RdqXDUAtnBTBkYwGcGM6F7GBlaVMjnsdiQ+OiIsJx7cq3gte8BCBXQk5rqkFKwpPpfMrFRjLvtTF59Gl6rBMVJ85/bYyGsLEJ6lqcCx14koNq0lRW835UGgJD11ZYEUqcZVfIqNhqgkLCP8DsN+W59pFIx76LInnSR+Iv3BhatWCwu22gIBS0o1eXNKJmV2Z7u2F89Nxctl2EQaoA4aYgzvbN02z4bESyflPbMRYERJBNOU8ijY0qW1kzDp657zHQ04VuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlRDtpxKBsyL5JgklaN26xV3p8ZMAW3isjqj+n3D/ng=;
 b=bQip8QUeNFaEhF4rdfMHBTcdrURV6MTOE+luXj9RagYnfYMm5nib5Kz2zEnjzP4JZqDrz/caG/1p24bv5Lv5cDVm2p4MV18Ag27oTy4cSpkOrevMuvBLkX97fxglG7gehApptoUJXBPhcIZlhia2nIebZ+qHRBis+bEWq57ebhnvAIhiK1RSofVbYpwXW5pSuniS8EcJv/q3a1M/hCgPkyPCI2FZqB5ZJExlC+CxhxRUrdGQT+HmAag7XwW0T8dfQiLG6zQHnNEQJuOt3/6p0Pu/kWZYNHRp0T184DMZTry2TqWPyQuhO6fUjZlfmFIj/8MpjdP+X+RwPa9j9prIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlRDtpxKBsyL5JgklaN26xV3p8ZMAW3isjqj+n3D/ng=;
 b=JuYMw7uoxAzgoOzfuWq/J7GaY6Xy49vbMtiKsJ0ZdTP1Fxc99ow7BM2s7CCzOXqrg9deM/2KoxOEDZz2Wfs68hhir3S14Rdpxq+KBPLL9zeNLW0Ss+fdHDy5185QeDZL+OgRCi7IBg0B1fY7ms4llvhWAlNKRvPDiwXIoytf7xQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:09:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Wed, 15 Feb 2023
 01:09:55 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v4 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v4 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZP+HGzScve8OH2E2rxWgxrnML6q7PNKQA
Date:   Wed, 15 Feb 2023 01:09:55 +0000
Message-ID: <20230215010950.ufazmdev7cvtef3n@synopsys.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
 <1676316676-28377-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1676316676-28377-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW6PR12MB8760:EE_
x-ms-office365-filtering-correlation-id: b52e1270-0fb6-41a5-7690-08db0ef15990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RvVEZjqGFVy0oYfMp2NU8+GXejulqCcG2+5V4irjePG3XFeHlvGj05VGBjmfGmRgFS+Tgx5o591q4h1ff33KymcXoIotO0YbDWKdmi7IkBkjTk/IiKjw72Hu/ogFHZTTeBifw78V9bz7lES2SwcfTmUp9cClnH4JTNtAYUvIGLMSUiYSlKZXcfzU71oej9cRPGkcCwkzWBQpR6QpIgqVHahXTmfWXthRU28i1xYFdAFza9e6iHnahc3MNTAAewRwJWUTqibgqurdkJvXBMERnB7mE324JACCatgS9mUvPo+ar2/0TmoqXTF2OVNks2HYubtdc2FQ167/F1iNf8BpaBFhvHx2C/cEgYDfnsCZQKjq1gHo18CUcQoqET/Qqfhkx1MwiBTIJ4BX6IwXmG0095M8M/UdM+iGfCnIcSbcZhXQsOLwPMHVPonDmSA1Q8LKcKN0W+ZmuZdcO79Jt4M86mbZhPxmwfZf5XD7rH1EYk5/tvUczGEH/9BuCI0Z3/DnVNEHkR9/4qVTf/7oVGiTDJac3oOXAIWs2RNBuEaTimMSLtFgaLMegHd6yaIz2kJb42zCligkW715eeZ5TceOrtAQuXfaoioozeK7V7qMkmcnPkVZdU3BWb90iWHFxb1tXzXLt4zf7rPbGySLPRhUJra/O6ZlhMcxpir7MFi6nySgFfPkEsClwseUpJqX69bC8qHW/9W9DF+MtHcFcow/7Ckv4/OUV+yBmewWlYnMZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199018)(122000001)(64756008)(8936002)(66476007)(76116006)(66446008)(66946007)(6916009)(8676002)(5660300002)(66556008)(41300700001)(38100700002)(4326008)(36756003)(2616005)(186003)(6506007)(1076003)(6512007)(26005)(38070700005)(71200400001)(54906003)(478600001)(6486002)(86362001)(316002)(83380400001)(2906002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFMeER5TVVtK1F3WU11SVQ1NWlYMndnK28wbGxBam1WZE9WSURRc216SW9p?=
 =?utf-8?B?aXpFL2hYMDZWTXlkZWhhM2szRlVJOW5WUnhEdGorYXRDNjFuOWdMcE15dEc0?=
 =?utf-8?B?Yk9UQllYRFZqUDk2WjVVQ2FKRitiaUM5cU1mOHVlNk8vUVZwbkJDUVRtdksr?=
 =?utf-8?B?cXJDbDd5VnJZR0thejdIMjFTNVRaa24wbVZSUnpVdndxaCtlUEEvbVZlM2pr?=
 =?utf-8?B?Ym50NzAyNmorbm16c1lVKzRFbE1vVW91UkFSSENJS3NwZ3dtbmxvd2RIRHRL?=
 =?utf-8?B?cXNGRWpESGFzb0p2aGk0TUhhYzBCMEcrUDhXTzNHdnJHcFNqVWZ4T3RhRU05?=
 =?utf-8?B?NU9Qa3dtL215YmlsZjVVWDhHSWlDc3VIbXdjNmtzUVpWS203cE5tTWQ3bVhP?=
 =?utf-8?B?eVdldkFUMldFWWFieWlrZXU1bXorUTdXdkIxYmNqb1doVy9YUXROVnhPemE4?=
 =?utf-8?B?bkZaNnJZMVU4eFZWWS92Y2VWazF2N2QvRkdGUTZGNm9peFdKVUQrdlJBQVZ5?=
 =?utf-8?B?SHlYREhQZ2t4NHJhcmViaVZRSllZbUtrVFVsL0ZtVFNSMFVab2VuWWpiY3Zw?=
 =?utf-8?B?NStmRGtJV2U0Q2Vnb0FsekM0dVViVkZJZ3lURis4bmhuTzVXMmhWQlVTWEdt?=
 =?utf-8?B?Si94emxNL05iUzJSeUsxMWJqaHY1VHI5dkVYbGJqd3Eza0E5UXZ4ZjNyUnFy?=
 =?utf-8?B?UWxIUWo1eVZOZVMyRDBkSEN4bXNYNGExL1RoT05OUEJWTjFoSHZsNHp4bDkx?=
 =?utf-8?B?N3NHMjI4cmVOTCsvUFk3dThueHlrRHpmV05hYzZjOHQwaWVNZUtuOFR5c1Jy?=
 =?utf-8?B?RXd5bmRpVHRGaXRUcTZrd3dHcHBwTkhha1NaUWJsdFFhQWJETW5SeERoYU5l?=
 =?utf-8?B?T0NUMW1CUktoeTlud1R6WHJObTh4UWFLanZleVJMaXE0bzdsU1ZSSC9NaEl1?=
 =?utf-8?B?S0xKUnZON1lwb2c0cDdZdml0RFdvb0tFd0tlNys5RmpPTDNTMDhEQUNpdHIx?=
 =?utf-8?B?cjM3aTdKa3BWSUhicVJIRTBwR2x3bnVpV1ZFNDcwVjZPUEV2TEgzTWxtWGxO?=
 =?utf-8?B?NUc3bEM5SlQwUlZtQjZ6bU5SOVE5M0YxR0NpWGJjUCtZdnhPUDJZOFpHQ0pa?=
 =?utf-8?B?TDhWc24rbGVPeWtZZHpTbEpLcGN6ZWEyOTFBTC9SS1JqVjNpQ0c4eFFjdnFr?=
 =?utf-8?B?OEtzd2puNmpsQmVCelM3RGVSM3JuZDNFS1ZRdnpCUHZWb0s2OHFieklKK2xV?=
 =?utf-8?B?bWhaZlIyYnNOaEpEUjNoTVhYbEQ1MUxJQWNsNlhCYXNNaFZQM0pCYldROXJv?=
 =?utf-8?B?Z3lYUkxaME5LSnh2ekZPQkhBR1NnOFFzNnlZeUFPblYwSzJWbHgyazlaYmE5?=
 =?utf-8?B?eDdLTXVvSEJLNjEweXAvR1Ryd2ZCbjFMNXREdlFOamNTU3YrTVI4bXUrOFE0?=
 =?utf-8?B?MTg0QjBHYjN1SUswaVhwakVpcWllbUtyWFY2cVdKem5ZYnB5M3d0TkFkRU1R?=
 =?utf-8?B?QWhNTUU1Uyt4OStaMm1GQUZlSUFqYjY2T0xBR1lUM1F5c290L0M0QkVXaTAz?=
 =?utf-8?B?TkRhdjNhbmtoMXo0NGNKejhLQTdDWk9scXAxZUM1cHZvbnM0RktZa0NZeW53?=
 =?utf-8?B?dmVKOCs1Zk9YN2xnYVFzQzBaQTNOaXZXNTRzNnpyZVo5endpSGFkVjFYYmpk?=
 =?utf-8?B?TVRqWXZCMm5XVGhJaG9NMFJjKy9yUkh3UStseUFYR0dVT3FLUFR2eXpZdDF3?=
 =?utf-8?B?WFVlZW1zYy85QlI1NHBJY0t2TmxkMHpPd0l5VEpna3ljUHZzRDJNVnYxSFhB?=
 =?utf-8?B?alROWE56R253cEkrYWwvM0dYN0dNTnhTQ0xJQUxJVzhiRktnREFieEZlNytT?=
 =?utf-8?B?YnhSc0YzQStXUVRKLzN4MDhRKzdraGdjOTFQc3RqMnNWYVBJbElEMkNqWjBG?=
 =?utf-8?B?VjZjcTRRc3hnWVhSM2V5emNuOTN6eXN6NVdQTzZVWDlFcmFzY3RNT0J4TEQv?=
 =?utf-8?B?WEE5Q1JTVXl3cTljalBlTThpMWN5Ni8zYU9MN29PUC8xY25uKzMwMlB5REYr?=
 =?utf-8?B?QmlHQ2hBQzBJb3dxSkZ1ay9nY0p2NjQvYVhmY1hLQlRReUFFVkdMWTNHL293?=
 =?utf-8?B?TGhUQ2VyTTFYQ3g5WXVYNlQ0RnZzVlhoR3lSNjZqcmttRzRKUWFjV2ZPOWpj?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E433C0DD288C74594CEE92B57AA4489@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hxF5FWeuROR4UzDhSvbS3dQHZXfHANdupAcoM8KoHvy/ghydrte2TUsk/pHFTRxuo7+QDrHaDaRot78u1yDEhGf//uNJa7thbjGoFRcplbn8qPWXTySP2M1O+6zv442tKEvEDeMz3bniX0+GzEnPM3LDU2eQJV5PHWoM520wd/V3U+iv9ZWoj5FsfKYaIMwwucG4IpVLkaaiJHqfznM+yFgPKxvq5rBhQyOtka1sQRdIANZUyYtpBcrsdtjdUJqLK26gOS22kvyBnjPdYQhiYa8zamgnhsL6cZF+qYBEHH99YxWbkKT+YroqabweYq7+p/oFIdEdql2PrP/aRbNGPZS7K/bo0/xo9vP5rCTt5ptlKvCb+6i2bQ9Mh+KjtmtTQuGJI6wGlzSKZq/aLemagZXkxi55D9aTz86zdS568fG9//ZD1FOvw6YcX08Wk0VHQZsjFPORJo8bbt8oSxEgLmeS41vKHgKaDBOCI7ABYxqpQI8UkyMfSt2CXAYfP044vonP+G0EarA3E2cg2HdKNZkhZ17rQIk9xt1n93cjjgEuhusrTmYGWykT8jr6zieGqifzapapZJK3BavnsxleGVrfX3rqk6PG9gKZrOvpGVTZov49KQXDd005+CWR3KnwX/Rxxmu9iJ/d//rx7aLnAVtapYb8JWwDq4s0ij1fk1+QDl0T8xMfXndIis18POiO7TK7V7dzvgtFraYSLBpwszUjoaPLragIYItvjhdHPprT9/MB48vqBX4cJJmU/ut22qbCVeNrHkcKtKeH9iUzUUbfigF2JXB1Xqz1KyaV9Yie/Pe6bD6mZXQ7jdfEHuYdx/1pbg7V0L6JnG+LuQniyHMswkzfSCE2Vriz+OkUC1usPcQVGhus2P05dRJYzoXT8n6Gfcl60PZmwsjyPDCcSc7YS8wpVCP0f+el2Mmsvm4=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52e1270-0fb6-41a5-7690-08db0ef15990
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:09:55.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWiX26LSVCYwdY1dB63jJZ+XcPQ811i9rETixAVews2CVzISWmYoI2eugmubcvsyB5emCpJXixvkLCIiKMXJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
X-Proofpoint-ORIG-GUID: G_Fmu7EnmoDbBCPZcY-bjrOQ4TRha5u6
X-Proofpoint-GUID: G_Fmu7EnmoDbBCPZcY-bjrOQ4TRha5u6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302150009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBk
ZXZpY2UgY2FuIGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQg
b2YNCj4gc3VzcGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVh
dHVyZSBzZWxlY3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBz
ZXQgdGhlIHJlbW90ZSB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNvbWUgaG9zdHMgbWF5IHRh
a2UgbG9uZ2VyIHRpbWUgdG8gaW5pdGlhdGUgdGhlIHJlc3VtZSBzaWduYWxpbmcgYWZ0ZXINCj4g
ZGV2aWNlIHRyaWdnZXJzIGEgcmVtb3RlIHdha2V1cC4gU28gYWRkIGFzeW5jIHN1cHBvcnQgdG8g
dGhlIHdha2V1cCBBUEkNCj4gYnkgZW5hYmxpbmcgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgNCArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNTgyZWJkOS4uY2M3ODIzNiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gQEAgLTExMTAsNiArMTExMCw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0K
PiAgICoJMwktIFJlc2VydmVkDQo+ICAgKiBAZGlzX21ldGFzdGFiaWxpdHlfcXVpcms6IHNldCB0
byBkaXNhYmxlIG1ldGFzdGFiaWxpdHkgcXVpcmsuDQo+ICAgKiBAZGlzX3NwbGl0X3F1aXJrOiBz
ZXQgdG8gZGlzYWJsZSBzcGxpdCBib3VuZGFyeS4NCj4gKyAqIEB3YWtldXBfY29uZmlndXJlZDog
c2V0IGlmIHRoZSBkZXZpY2UgaXMgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cC4NCj4gICAq
IEBpbW9kX2ludGVydmFsOiBzZXQgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIGludGVydmFsIGlu
IDI1MG5zDQo+ICAgKgkJCWluY3JlbWVudHMgb3IgMCB0byBkaXNhYmxlLg0KPiAgICogQG1heF9j
ZmdfZXBzOiBjdXJyZW50IG1heCBudW1iZXIgb2YgSU4gZXBzIHVzZWQgYWNyb3NzIGFsbCBVU0Ig
Y29uZmlncy4NCj4gQEAgLTEzMjcsNiArMTMyOCw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gIA0KPiAg
CXVuc2lnbmVkCQlkaXNfc3BsaXRfcXVpcms6MTsNCj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJh
Y2tzOjE7DQo+ICsJdW5zaWduZWQJCXdha2V1cF9jb25maWd1cmVkOjE7DQo+ICANCj4gIAl1MTYJ
CQlpbW9kX2ludGVydmFsOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Vw
MC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBpbmRleCA2MWRlNjkzLi5mOTBmYTU1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMNCj4gQEAgLTM1Niw2ICszNTYsOSBAQCBzdGF0aWMgaW50IGR3YzNfZXAwX2hh
bmRsZV9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YywNCj4gIAkJCQl1c2Jfc3RhdHVzIHw9IDEgPDwg
VVNCX0RFVl9TVEFUX1UxX0VOQUJMRUQ7DQo+ICAJCQlpZiAocmVnICYgRFdDM19EQ1RMX0lOSVRV
MkVOQSkNCj4gIAkJCQl1c2Jfc3RhdHVzIHw9IDEgPDwgVVNCX0RFVl9TVEFUX1UyX0VOQUJMRUQ7
DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQl1c2Jfc3RhdHVzIHw9IGR3Yy0+Z2FkZ2V0LT53YWtldXBf
YXJtZWQgPDwNCj4gKwkJCQkJVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOw0KPiAgCQl9DQo+ICAN
Cj4gIAkJYnJlYWs7DQo+IEBAIC00NzYsNiArNDc5LDcgQEAgc3RhdGljIGludCBkd2MzX2VwMF9o
YW5kbGVfZGV2aWNlKHN0cnVjdCBkd2MzICpkd2MsDQo+ICANCj4gIAlzd2l0Y2ggKHdWYWx1ZSkg
ew0KPiAgCWNhc2UgVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOg0KPiArCQlkd2MtPmdhZGdldC0+
d2FrZXVwX2FybWVkID0gc2V0Ow0KPiAgCQlicmVhazsNCj4gIAkvKg0KPiAgCSAqIDkuNC4xIHNh
eXMgb25seSBmb3IgU1MsIGluIEFkZHJlc3NTdGF0ZSBvbmx5IGZvcg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
aW5kZXggM2M2M2ZhOS4uYjdmZWY1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0yNTgsNyAr
MjU4LDcgQEAgaW50IGR3YzNfc2VuZF9nYWRnZXRfZ2VuZXJpY19jb21tYW5kKHN0cnVjdCBkd2Mz
ICpkd2MsIHVuc2lnbmVkIGludCBjbWQsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAt
c3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gK3N0
YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YywgYm9vbCBhc3lu
Yyk7DQo+ICANCj4gIC8qKg0KPiAgICogZHdjM19zZW5kX2dhZGdldF9lcF9jbWQgLSBpc3N1ZSBh
biBlbmRwb2ludCBjb21tYW5kDQo+IEBAIC0zMjUsNyArMzI1LDcgQEAgaW50IGR3YzNfc2VuZF9n
YWRnZXRfZXBfY21kKHN0cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBjbWQsDQo+ICAN
Cj4gIAkJCWZhbGx0aHJvdWdoOw0KPiAgCQljYXNlIERXQzNfTElOS19TVEFURV9VMzoNCj4gLQkJ
CXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3Yyk7DQo+ICsJCQlyZXQgPSBfX2R3YzNfZ2Fk
Z2V0X3dha2V1cChkd2MsIGZhbHNlKTsNCj4gIAkJCWRldl9XQVJOX09OQ0UoZHdjLT5kZXYsIHJl
dCwgIndha2V1cCBmYWlsZWQgLS0+ICVkXG4iLA0KPiAgCQkJCQlyZXQpOw0KPiAgCQkJYnJlYWs7
DQo+IEBAIC0yMjY5LDYgKzIyNjksMjIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZXBfb3Bz
IGR3YzNfZ2FkZ2V0X2VwX29wcyA9IHsNCj4gIA0KPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8N
Cj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZW5hYmxlX2xpbmtzdHNfZXZ0cyhzdHJ1
Y3QgZHdjMyAqZHdjLCBib29sIHNldCkNCj4gK3sNCj4gKwl1MzIgcmVnOw0KPiArDQo+ICsJaWYg
KERXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDI1MEEpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwly
ZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19ERVZURU4pOw0KPiArCWlmIChzZXQpDQo+
ICsJCXJlZyB8PSBEV0MzX0RFVlRFTl9VTFNUQ05HRU47DQo+ICsJZWxzZQ0KPiArCQlyZWcgJj0g
fkRXQzNfREVWVEVOX1VMU1RDTkdFTjsNCj4gKw0KPiArCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19ERVZURU4sIHJlZyk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRf
Z2V0X2ZyYW1lKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzCQkq
ZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gQEAgLTIyNzYsNyArMjI5Miw3IEBAIHN0YXRpYyBp
bnQgZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnKQ0KPiAgCXJldHVy
biBfX2R3YzNfZ2FkZ2V0X2dldF9mcmFtZShkd2MpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50
IF9fZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICtzdGF0aWMgaW50IF9f
ZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCBkd2MzICpkd2MsIGJvb2wgYXN5bmMpDQo+ICB7DQo+
ICAJaW50CQkJcmV0cmllczsNCj4gIA0KPiBAQCAtMjMwNyw5ICsyMzIzLDEzIEBAIHN0YXRpYyBp
bnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKGFzeW5jKQ0KPiArCQlkd2MzX2dhZGdldF9lbmFi
bGVfbGlua3N0c19ldnRzKGR3YywgdHJ1ZSk7DQo+ICsNCj4gIAlyZXQgPSBkd2MzX2dhZGdldF9z
ZXRfbGlua19zdGF0ZShkd2MsIERXQzNfTElOS19TVEFURV9SRUNPVik7DQo+ICAJaWYgKHJldCA8
IDApIHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBwdXQgbGluayBpbiBSZWNv
dmVyeVxuIik7DQo+ICsJCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBmYWxz
ZSk7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+IEBAIC0yMzIxLDYgKzIzNDEsMTMg
QEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
CQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfRENUTCwgcmVnKTsNCj4gIAl9DQo+ICANCj4g
KwkvKg0KPiArCSAqIFNpbmNlIGxpbmsgc3RhdHVzIGNoYW5nZSBldmVudHMgYXJlIGVuYWJsZWQg
d2Ugd2lsbCByZWNlaXZlDQo+ICsJICogYW4gVTAgZXZlbnQgd2hlbiB3YWtldXAgaXMgc3VjY2Vz
c2Z1bC4gU28gYmFpbCBvdXQuDQo+ICsJICovDQo+ICsJaWYgKGFzeW5jKQ0KPiArCQlyZXR1cm4g
MDsNCj4gKw0KPiAgCS8qIHBvbGwgdW50aWwgTGluayBTdGF0ZSBjaGFuZ2VzIHRvIE9OICovDQo+
ICAJcmV0cmllcyA9IDIwMDAwOw0KPiAgDQo+IEBAIC0yMzQ2LDEzICsyMzczLDM2IEBAIHN0YXRp
YyBpbnQgZHdjM19nYWRnZXRfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnKQ0KPiAgCXVuc2ln
bmVkIGxvbmcJCWZsYWdzOw0KPiAgCWludAkJCXJldDsNCj4gIA0KPiArCWlmICghZHdjLT53YWtl
dXBfY29uZmlndXJlZCkgew0KPiArCQlkZXZfZXJyKGR3Yy0+ZGV2LCAicmVtb3RlIHdha2V1cCBu
b3QgY29uZmlndXJlZFxuIik7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiAg
CXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQlyZXQgPSBfX2R3YzNf
Z2FkZ2V0X3dha2V1cChkd2MpOw0KPiArCWlmICghZHdjLT5nYWRnZXQtPndha2V1cF9hcm1lZCkg
ew0KPiArCQlkZXZfZXJyKGR3Yy0+ZGV2LCAibm90IGFybWVkIGZvciByZW1vdGUgd2FrZXVwXG4i
KTsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKwlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChk
d2MsIHRydWUpOw0KPiArDQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBm
bGFncyk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X3NldF9yZW1vdGVfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgc2V0
KQ0KPiArew0KPiArCXN0cnVjdCBkd2MzCQkqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gKwl1
bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gKwlkd2MtPndha2V1cF9jb25maWd1cmVkID0gISFzZXQ7DQo+ICsJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwlyZXR1cm4g
MDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zZXRfc2VsZnBvd2VyZWQo
c3RydWN0IHVzYl9nYWRnZXQgKmcsDQo+ICAJCWludCBpc19zZWxmcG93ZXJlZCkNCj4gIHsNCj4g
QEAgLTI5NzgsNiArMzAyOCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2FzeW5jX2NhbGxi
YWNrcyhzdHJ1Y3QgdXNiX2dhZGdldCAqZywgYm9vbCBlbmFibGUpDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IHVzYl9nYWRnZXRfb3BzIGR3YzNfZ2FkZ2V0X29wcyA9IHsNCj4gIAkuZ2V0X2ZyYW1l
CQk9IGR3YzNfZ2FkZ2V0X2dldF9mcmFtZSwNCj4gIAkud2FrZXVwCQkJPSBkd2MzX2dhZGdldF93
YWtldXAsDQo+ICsJLnNldF9yZW1vdGVfd2FrZXVwCT0gZHdjM19nYWRnZXRfc2V0X3JlbW90ZV93
YWtldXAsDQo+ICAJLnNldF9zZWxmcG93ZXJlZAk9IGR3YzNfZ2FkZ2V0X3NldF9zZWxmcG93ZXJl
ZCwNCj4gIAkucHVsbHVwCQkJPSBkd2MzX2dhZGdldF9wdWxsdXAsDQo+ICAJLnVkY19zdGFydAkJ
PSBkd2MzX2dhZGdldF9zdGFydCwNCj4gQEAgLTM4MTksNiArMzg3MCw4IEBAIHN0YXRpYyB2b2lk
IGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3RfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAlkd2MtPmdhZGdldC0+c3BlZWQgPSBVU0JfU1BFRURfVU5LTk9XTjsNCj4gIAlkd2MtPnNl
dHVwX3BhY2tldF9wZW5kaW5nID0gZmFsc2U7DQo+ICsJZHdjLT5nYWRnZXQtPndha2V1cF9hcm1l
ZCA9IGZhbHNlOw0KPiArCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBmYWxz
ZSk7DQo+ICAJdXNiX2dhZGdldF9zZXRfc3RhdGUoZHdjLT5nYWRnZXQsIFVTQl9TVEFURV9OT1RB
VFRBQ0hFRCk7DQo+ICANCj4gIAlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0Up
IHsNCj4gQEAgLTM5MTIsNiArMzk2NSw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X3Jlc2V0
X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJlZyAmPSB+RFdDM19EQ1RMX1RTVENU
UkxfTUFTSzsNCj4gIAlkd2MzX2dhZGdldF9kY3RsX3dyaXRlX3NhZmUoZHdjLCByZWcpOw0KPiAg
CWR3Yy0+dGVzdF9tb2RlID0gZmFsc2U7DQo+ICsJZHdjLT5nYWRnZXQtPndha2V1cF9hcm1lZCA9
IGZhbHNlOw0KPiArCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdjLCBmYWxzZSk7
DQo+ICAJZHdjM19jbGVhcl9zdGFsbF9hbGxfZXAoZHdjKTsNCj4gIA0KPiAgCS8qIFJlc2V0IGRl
dmljZSBhZGRyZXNzIHRvIHplcm8gKi8NCj4gQEAgLTQwNjQsNyArNDExOSw3IEBAIHN0YXRpYyB2
b2lkIGR3YzNfZ2FkZ2V0X2Nvbm5kb25lX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
CSAqLw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBfaW50ZXJy
dXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93YWtldXBf
aW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBldnRpbmZvKQ0KPiAgew0K
PiAgCS8qDQo+ICAJICogVE9ETyB0YWtlIGNvcmUgb3V0IG9mIGxvdyBwb3dlciBtb2RlIHdoZW4g
dGhhdCdzDQo+IEBAIC00MDc2LDYgKzQxMzEsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF93
YWtldXBfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCWR3Yy0+Z2FkZ2V0X2RyaXZl
ci0+cmVzdW1lKGR3Yy0+Z2FkZ2V0KTsNCj4gIAkJc3Bpbl9sb2NrKCZkd2MtPmxvY2spOw0KPiAg
CX0NCj4gKw0KPiArCWR3Yy0+bGlua19zdGF0ZSA9IGV2dGluZm8gJiBEV0MzX0xJTktfU1RBVEVf
TUFTSzsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfbGlua3N0c19jaGFu
Z2VfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+IEBAIC00MTU3LDYgKzQyMTQsMTAgQEAg
c3RhdGljIHZvaWQgZHdjM19nYWRnZXRfbGlua3N0c19jaGFuZ2VfaW50ZXJydXB0KHN0cnVjdCBk
d2MzICpkd2MsDQo+ICAJfQ0KPiAgDQo+ICAJc3dpdGNoIChuZXh0KSB7DQo+ICsJY2FzZSBEV0Mz
X0xJTktfU1RBVEVfVTA6DQo+ICsJCWR3YzNfZ2FkZ2V0X2VuYWJsZV9saW5rc3RzX2V2dHMoZHdj
LCBmYWxzZSk7DQo+ICsJCWR3YzNfcmVzdW1lX2dhZGdldChkd2MpOw0KDQpJIGRvbid0IHRoaW5r
IHRoaXMgc2hvdWxkIGJlIGEgcHJvYmxlbSBmb3IgZHdjX3VzYjMgMi41MGEgYW5kIHByaW9yLiBC
dXQNCmZvciBhIGRldmljZSB0aGF0IGVuYWJsZXMgbGluayBzdGF0ZSBjaGFuZ2UgZXZlbnQgYWxs
IHRoZSB0aW1lLCBpdCB3b3VsZA0KY2FsbCB0aGlzIGV2ZXJ5IHRpbWUgbGluayB0cmFuc2l0aW9u
cyB0byBVMC4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIHNpZGUNCmVmZmVjdCBjYW4gYmUuIENhbiB3
ZSBhZGQgYSB3YWtldXBfYXJtZWQgY2hlY2sgaGVyZSB0byBwcmV2ZW50IHBvc3NpYmxlDQpyZWdy
ZXNzaW9uPw0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsJCWJyZWFrOw0KPiAgCWNhc2UgRFdDM19M
SU5LX1NUQVRFX1UxOg0KPiAgCQlpZiAoZHdjLT5zcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIpDQo+
ICAJCQlkd2MzX3N1c3BlbmRfZ2FkZ2V0KGR3Yyk7DQo+IEBAIC00MjI1LDcgKzQyODYsNyBAQCBz
dGF0aWMgdm9pZCBkd2MzX2dhZGdldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywNCj4gIAkJ
ZHdjM19nYWRnZXRfY29ubmRvbmVfaW50ZXJydXB0KGR3Yyk7DQo+ICAJCWJyZWFrOw0KPiAgCWNh
c2UgRFdDM19ERVZJQ0VfRVZFTlRfV0FLRVVQOg0KPiAtCQlkd2MzX2dhZGdldF93YWtldXBfaW50
ZXJydXB0KGR3Yyk7DQo+ICsJCWR3YzNfZ2FkZ2V0X3dha2V1cF9pbnRlcnJ1cHQoZHdjLCBldmVu
dC0+ZXZlbnRfaW5mbyk7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgRFdDM19ERVZJQ0VfRVZFTlRf
SElCRVJfUkVROg0KPiAgCQlpZiAoZGV2X1dBUk5fT05DRShkd2MtPmRldiwgIWR3Yy0+aGFzX2hp
YmVybmF0aW9uLA0KPiBAQCAtNDQ4NSw2ICs0NTQ2LDcgQEAgaW50IGR3YzNfZ2FkZ2V0X2luaXQo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MtPmdhZGdldC0+c2dfc3VwcG9ydGVkCT0gdHJ1ZTsN
Cj4gIAlkd2MtPmdhZGdldC0+bmFtZQkJPSAiZHdjMy1nYWRnZXQiOw0KPiAgCWR3Yy0+Z2FkZ2V0
LT5scG1fY2FwYWJsZQk9ICFkd2MtPnVzYjJfZ2FkZ2V0X2xwbV9kaXNhYmxlOw0KPiArCWR3Yy0+
Z2FkZ2V0LT53YWtldXBfY2FwYWJsZQk9IHRydWU7DQo+ICANCj4gIAkvKg0KPiAgCSAqIEZJWE1F
IFdlIG1pZ2h0IGJlIHNldHRpbmcgbWF4X3NwZWVkIHRvIDxTVVBFUiwgaG93ZXZlciB2ZXJzaW9u
cw0KPiAtLSANCj4gMi43LjQNCj4g
