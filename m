Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A96651C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjAKC2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjAKC15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:27:57 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F46438;
        Tue, 10 Jan 2023 18:27:56 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B13tk4016308;
        Tue, 10 Jan 2023 18:27:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=U9znm9WNLV7IlfQ9MCJmCdzfF3Ku8t32QXW1TfAh7is=;
 b=erQy3cez1UAChL6kKK20fU3BHQuNQ/VBp/dFulFWL6qY50HeVeJJGkGEHzYK6GZ3iqTN
 ihcG/5gzG/MEKiF8wd+bFueOOvUQtxHjQ0WetVfU2fwgmg0FzhfJ33inS+3mhXb3jUT3
 rFREbKHdN/7E8L7cbp0BgJLyb/ykwR6UrjYsxi8faj3kSftbRSz2D5e8crZHB/7HW10o
 At2bQM8vvOOWZKN5HlSmVxtyM+4kXEHyzjbx/3OrdQgmKacVP8/ccXMT3gMBKIJ3MTSG
 CZ/f+4yGAZ8JotEH4KL143U+0HTPAy9RYRuAJVNqb12INNL2w7JKbew8XRUv4ZJmImF6 nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n1k4dr82n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 18:27:40 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5493C400AF;
        Wed, 11 Jan 2023 02:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673404060; bh=U9znm9WNLV7IlfQ9MCJmCdzfF3Ku8t32QXW1TfAh7is=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jnF9mabPUQLzK6jVu6iuH7bR0kqUVstybcGG+vJKAzAtdQwekdLBIxneGLgvAbvEI
         z8vjShFMu4SSx/Hl2tr6M1mPB1p6LLJcXVhJ/wU8EGio0fUlNuX/LGre9nMLwSVVnA
         ti9ZgoCQ8A1t93x1Z4Tmqo8PApbfIluCDHyQSecdw5jeNNn9l0yYxARXzn73/pi2Ml
         geyZAq1eDQ4GKjaDqjwPAI7DcolSa3FZ9qRj1/REmD9e5/QRNRBWATfsW2XV/KQi/5
         DcXXK1xZzvYjbgLxnm/VjoohFeYD6121yyb5TVrgQ21rw3IUNQt48yN52xW4D328Xl
         rAWeUXGC5Lu4A==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B2AACA0075;
        Wed, 11 Jan 2023 02:27:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3474B8016B;
        Wed, 11 Jan 2023 02:27:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lymXOimb";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6shv73NQwEbvCAC0NXJYHUmD5Lt+IrCYWfuEb/dBkjPrO5UdUpwBGvHsoss2sR60tg4YHQB1TAztfOucQg7Bt0kNWKjq5KhT1F1GzI35BwUWSX1176LIehv50AcqtaYPmWEzXbxgL6BGvAhbPY3t2kGtgw6Xw64+VPYzVj/JdaF8T5rbwEUwSSF6j0z6Toz4+7sjmUBy/fgIV9Af2EWscyDCRx3NvGrMIv651eYkrPW0BZ9N1yZbJ8QssajlgqhByA7HnMRb1v6luXPK0ukk/KmAPfghjzIc5Cun+WBPMybquuMEJjsXR7vwqd6Z8DupzOMLythpIW+dGvOVAbyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9znm9WNLV7IlfQ9MCJmCdzfF3Ku8t32QXW1TfAh7is=;
 b=a39ya8hyiIuYqabj58OwWIay0xOh0JKlu5yg7Zoz4RO8PzzZVskq0mwGpZSs6yxSvMWP6Zaac6B9KKib8HJdl/oIVJFH/M0jYyYEPjzDlWUQISfgCHlNbIU5w9C/OOJr23YAsHVnVk1KQ3BT5zKLe9leZaDs51X/JPjoaiKRD9uWgeq9tDo5PfRB1t/iqAlnhItvevhN4DhnixlCVCzfIYDPBNHrtLV8YVBr44iD45LNIaG1U86S45CGvUvoS9jEa6UdclGsMKNEI56uv79jULFJHe9hztQz5YBP1o+KGHx0fzd6ZNRmjJRGMKojSRxWHgb1ODYAhUADdAiE3mYfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9znm9WNLV7IlfQ9MCJmCdzfF3Ku8t32QXW1TfAh7is=;
 b=lymXOimbBbF27jC6VK3E1O+LsHjDtseshyoSk1Xcu2tR6t9zpZpV+ObyGoFD3Osk6cUUtzmMYkoHHgFSjXbAk7bfpIS95mWxb7fP1w7fZ3sTCSvtbTuZWRm9XSPkCBqF4wG3WbE3upbwe4TfSEvf6a6CV1dQu8t1ld6tTWnuWU4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 02:27:34 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 02:27:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rICAAH0sAIAAD+kAgAADfgCAAAI7gIAAShIAgAESQYCAAB19AIAAC5QA
Date:   Wed, 11 Jan 2023 02:27:34 +0000
Message-ID: <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
References: <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
 <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
In-Reply-To: <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB6069:EE_
x-ms-office365-filtering-correlation-id: 0f1a4f1d-c03c-46df-785e-08daf37b65fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0upRMZ4yC+3vgGyqIDersgYIOm56PfKrHQbBt5kcHmPmPHFrmJFNGMv1j0y5nC4FeR6d8zd3eTwn0/bbdA90ckpQcJpOXHNNZ4dS+06c+Zaqb2pabLPNpnLONMQVVB+MZpNnEoOWVpFawkxQ128OVhJ7u0oY8zx3UqFlFFRjaUh/eaMR4+YKmBE16w/77O7RynkAcAp+KHnV/696xBixY9zgh+vcA1AUwW43oxID2k9FFX9Q4w/wlY28DG8+SSQ7KevoGi45ZjtuvsaI+Ki6gD2FTZWZMXM6NcGUzdjZoTBPl/39x6EDGpNjBBEb7h17zEIgGxnSD4IBTJERcaqTnSqH+s3qr58QCTGp0AdhqOhi/dKVeQKndUZlWCWjWVDNDbaulkmA6mqCqENRQ1bMIwWTIh3uF/2BB9Gj4DAbPmp7glcuRYsLVxyY10+s5GfRhyQ18HeQ+vn6s9pmrKdcdkxOtB438eSCNa0r4bTLzVkeA0V5UmfsDQT2kLA1ojZHW3VH+W1oQnN0FUSaf9hbwyadgQiRlPNU6RKI9+ZypQ0ulGv4qnPcgSGtpSBHlERoaUbSHpZvywwv3Ek8/4Gm7jxFKi2BiLBPFzguUzPEFP0KLDBfNpXCTdoa8DRiuI6meDRut+y5Lhy8xCCrVMmPjbcnGqBQStPS42ya4OaCDClE5/21i/grfU7xcZ0cQRFZcsAlz811LMcCNEDhfR+1xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(6486002)(316002)(478600001)(71200400001)(5660300002)(8936002)(186003)(36756003)(83380400001)(2906002)(26005)(6916009)(54906003)(6512007)(38070700005)(122000001)(53546011)(6506007)(64756008)(4326008)(8676002)(66946007)(66476007)(2616005)(3716004)(41300700001)(66556008)(86362001)(66446008)(76116006)(38100700002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U20vcC9tczBhaTQ5VG5qUFU5N1N2V1UyeG9OeFZYbXJEcW1PR2pNam1va3BI?=
 =?utf-8?B?UmJVaGtOeHRaclFtWHQzeFlJQUJ2dkI4QkZxOXVjWXAwU0Z0SGsxSWdHbFZx?=
 =?utf-8?B?dUhZZTdGZVhXZzlxWVhRSFhxQjdPK0sySzllY2VJK3ZwazBCcmxRekh3VHQ4?=
 =?utf-8?B?ZDdsNU55SGRCQzZ0ZFZ6bmcvWXQ3UlpuOEVSanBPK0swWlkvM0Zla21uS0RM?=
 =?utf-8?B?dWF2U3RwSGxJa1VmNFpkcE9JMTIrcFVqMmdKVC96TkhreFlBc010Y1dKZXdM?=
 =?utf-8?B?YkJtNVl1bHVyRVN2anFITFJBOXFQMk50SDhLcnZYQ05UUndBNjR1VmJ1SFhN?=
 =?utf-8?B?TitiR00zOHpJc0cxMXRMWWhCTE5Td1pKMkpPYVRPeFhsTXBvU0J6c3IzeDVN?=
 =?utf-8?B?QlRtK0Y2dmxvMVJKbGh1WWxnVmdXWmlzQkpmWDJvYjJWTmx6Smx4ZGJtdkx1?=
 =?utf-8?B?eS9Rdm1EcDQ2NjRKNUZockVlc2VEdzBsSHcyS3dOQWJtYXBGRnJHc1N0cExt?=
 =?utf-8?B?TW1ST0lEUG9wQlFVMTRZNzNhS09hRytncDJiS0tEZitFOVYrOU1zVEF0b0dE?=
 =?utf-8?B?czU0cDVUeW1UT1hYNVdyRmFWQi96R2FSOU1yYnc2amI3OGVDa3JUY202cmdt?=
 =?utf-8?B?ZnRaV1dXSWNVV3EzM0FHNTRMcWRMWldyN0NXY1lyZklOWkcyb2ozNzcwa3pG?=
 =?utf-8?B?LzdNNTVUWDlEYm13MzR6M3AzT3BuR09ZY2NRa0tIQzJkR3crUGdoVjJMNDlw?=
 =?utf-8?B?N1hTODFQVjE3bmFTdjZsb3V5RHU5ajFKUkUzM2hsbjRWVWVQaS96YVFhZmI1?=
 =?utf-8?B?NXVYNThJODA0K2NTNjEybjlsMXQ0SGpjczFnNHRHZm1QemJtME5NMVk2WlVU?=
 =?utf-8?B?MEVabTAybXFRdDEzQ0VnajcrQ2lSSW9saGp0UXR2V0hSZ3BIZGhBVTRFUGx4?=
 =?utf-8?B?eFJEbC9xaC9vaGRFeVJHMTMrOFZ5QlV1Skl6U1JOSG9uYWg5UUN3ZU93Qlc2?=
 =?utf-8?B?dWZMYWE1Y3hmNHlzZDk3QWhPeWxWNU10WnZscE04WDRKa21iRFRyWmFPYlZo?=
 =?utf-8?B?bzEvSXBUVldPZVpzSjJucjVzd2lTamhTWlFudDFFMXFvYmJJcy9BQ2hlVnBE?=
 =?utf-8?B?ODFXbE9qNFZXcmdQU2ZCanZ3MFRjcHJmMVcxSTFWZjJHc2V1OTQ5OTcyS0dZ?=
 =?utf-8?B?YTRlaGVidWErVmxIMC8yNXRtMkR1R1Z1QWVVZHE5VUpiQXZaMHI0N3VBazBV?=
 =?utf-8?B?NlVFbnVCd3NKWUNZQ3FHNS83N2NVdytOUEZ2U3BMcnhSZXhhUm9wTHpCeUQ2?=
 =?utf-8?B?bFhaTElweTZvMHNodC82U1IxV05TeXA1KzRYemp3V1h5am16Z1huZzZDSmF4?=
 =?utf-8?B?aGtRdWJJNmcyNDJNVGdOR2poSU5Ec0NHclpRNFlFQ2E0M3NLeHhRNWhGVGVj?=
 =?utf-8?B?QXFwUFJVd3RvL0tMQm1XbzdYYWh3R2JzTGxHVGVvM29tcDB4eVI5QkIrdlpI?=
 =?utf-8?B?RGhZa3JUcmcvZ3kvalJhVGRzdXgyancxWVB6UGpkcWZnTUFQUTJTOHNEVUJl?=
 =?utf-8?B?NFZMNjBLNjNqTDE3Q0ozTGZCZmg1bnU0b2RaZlc1N2IvZTEwVk9VZWUwdGJv?=
 =?utf-8?B?YnoyNy9oaVNIWThQdlltaG8wUk8yNFJ1TDMrSis1L1Z2TVR3ZWtsOUM5SzdL?=
 =?utf-8?B?cFd3TC81QTBMK3dMQWNqeGk4dFFVYVJRSFJrSnJycTJ1V0NCUGtyVFpsWU94?=
 =?utf-8?B?aUJMNElRZ3ZNYVdlZzFKb2RRdVVWZ2QyUUJCT0NLaFBxOTVUblJ4blRnUHN1?=
 =?utf-8?B?TzY1VWpBQ3gzb2ZqRWIxTnl3bVJVaE5oaStNYnBzNHo1Nk1zVzZ3SUVYcmdh?=
 =?utf-8?B?aE1pL3NaYmorRlZrSzlYNTNCT1dUbTFWVzd6ankzQjJtMlJNbnZYUlZobVhD?=
 =?utf-8?B?cXlMbWw0RlJRa2lhWnRRZk5BK1N3L2NaVHdPKzUrSjJYNFNtbVRkeHlvZUZF?=
 =?utf-8?B?K2w5MUNuQ29xYWdhdm1XQldGa0RGWGh4WDZ2N1RETnV3SHhGb01saHdZcUNu?=
 =?utf-8?B?bngvdnBFVkVKTWZoK1RxbjNXSlltMUNJWTNydndLazAxMGNNV3QzVVNGWHM2?=
 =?utf-8?B?M0NhOE55ZHIxQVhkM0hJV3NlMWNTdS9sSkdqejNsTUg0YlV2RythRmszcncz?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F3C59D109BCDF448B9112AF169BB196@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UEVnNzFkWm1MclVmZk5rMUREcDB6cWRyQXd0bnRPUmd6TkdadVZtN3FmUVF0?=
 =?utf-8?B?N3Y4MjU0NW9Sb3pvbGMrc0JQSmFOd1l1WUwyMk9MRUx6S2hmVnQ1czFqVndw?=
 =?utf-8?B?RVliaHVpUTI0YnVFN3pmai9zMmhJaGhLMG9UWXBVSVJpQnZ3ZWQzbDhaMnp2?=
 =?utf-8?B?SjNRc1JlQUR3SkgvUWxPZ3E2L052aXRwaXJFYXkwbko5alVTTGpyY3FZQnRR?=
 =?utf-8?B?dlZCbjNCSGJ2WXhtZHZpZ1BJbUxrYlBXa1BySDJFaDk2T1ljSTBEdUR4M2dD?=
 =?utf-8?B?ZDdhRmgwb3JVdy85S2dkYWZJN3lTZjc0aXdtTE5kUXQ3N1Z0UVM2SENZdXRa?=
 =?utf-8?B?aGNEWnVRRGp0ZC9FcmR5dERSVjBpVHNhTnpqU0M4K3pDeG9OaTgycHltTUh0?=
 =?utf-8?B?Qk1oVXoxYlRFa01SN1gxd0FZK214UXhjNUpIMm1xNWFrUGZDZloyVjZxNEhr?=
 =?utf-8?B?djFTWkZPV0UzdFFRK0JpK0txcm5TN3hJMWwrazZXZlZ2ajhjd0UvMDNRa0dY?=
 =?utf-8?B?OWNJRmN3R0dQV2ZWVWh4TkRkdERFMkRkdnhyaVhuM2VBTW1sREJxSitVZmxZ?=
 =?utf-8?B?RXBhTXFiNkVpTmRrUWNuL1k0TTAvdnhINmhVWU9HKy9vUllydStwOVBmL2ll?=
 =?utf-8?B?bnFuZjhnbnVOcnVvZ2twOTgzOGljelZjeTZjY3BWMDY4OFdMd1JOZVVURkM1?=
 =?utf-8?B?YSt6bHN4b3lpdVQ3VHlLd2RNQUZKUTR0UStyRCtNTVQxNUlSQXpQQlE3RW44?=
 =?utf-8?B?ZHpzZjIwZGhHKytNTW1QUVR2dkpLYUFKRzNjby8ybGJ3WDFxUUExUjBRL2RX?=
 =?utf-8?B?MWtBa1JNOERHNjk3bFZJeHVsV2dkaHkzdldpMzhqaWxBVG9yR2lvNUYydC84?=
 =?utf-8?B?Vzl0WVVsM09kc0VvanRHNVltOXlpN21uUGU3Y0NkcFJEVXdMYjFjWDZYU0xS?=
 =?utf-8?B?VmgxTG9XSkk3S0VBSHZscWRVSUowZXBzcTUrN1F6SnhJN0dVYzhKMlBqUHJJ?=
 =?utf-8?B?bGFteWVJSlVPT1hEc0xtRkJPRm9ETlFVa3VnR2RUUWw5K0dwbm9mUk01eHBs?=
 =?utf-8?B?Z3VSelV3RlRtUW9nVXJha0RKMkpmN2pnY1RWUVpJTjIxWkFJRS9YUEUxV1E4?=
 =?utf-8?B?WHE0Q09RNmo5WlhBaWJKNGVxTUNqS0xlK1VTRkY2a2c4VUdicXlQT3gvWWlE?=
 =?utf-8?B?MlN4TGZJVk44dUJmRG1rS2NLbnZQK2NZWTduNjA4M1BlekxFSzZYck1sNG1z?=
 =?utf-8?Q?0eLezuiU5bpRWmH?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1a4f1d-c03c-46df-785e-08daf37b65fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 02:27:34.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vgrpvq6POwKj7zoIXHoiaCpsrpLpHL4jdapc5oAmAKf1/1Tbr+MHD9yo7eYrWWKynnYmF1WMlZnSM3OJhEXQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Proofpoint-GUID: CfBED7y-NVZUZ79ATsEB5CYjcl6WtoFh
X-Proofpoint-ORIG-GUID: CfBED7y-NVZUZ79ATsEB5CYjcl6WtoFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=315 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTEsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IA0KPiBPbiAxLzExLzIw
MjMgODowMCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IA0KPiA+ID4gb25lIG1vcmUgcXVl
c3Rpb24sIGlzIGl0IGxlZ2FjeSBQQ0llIGRldmljZSBzdGlsbCBleGlzdCBpbiByZWFsIHdvcmxk
ID8gYW5kDQo+ID4gPiBhbnkgVklEL1BJRCBpbmZvID8NCj4gPiBDdXJyZW50bHksIGFsbCBkd2Mz
IFBDSWUgZGV2aWNlcyBhcmUgYWZmZWN0ZWQuIFNvbWUgc2V0dXBzIGFyZSBtb3JlDQo+IA0KPiAN
Cj4gaWYgbm9uIFBDSWUgZGV2aWNlIGhhdmUgbm8gc3VjaCBpc3N1ZSwgY2FuIHdlIGRvIHNvbWUg
aW1wcm92ZW1lbnQgZm9yIGl0ID8NCj4gDQo+IGxpa2UgbmV3IGZsYWcgb3Igc3RhdGljIGtleS9q
dW1wIGxhYmVsIHRvIGltcHJvdmUgaW50ZXJydXB0IGhhbmRsZXIgPw0KPiANCg0KVGhlcmUgYXJl
IGRpZmZlcmVudCB3YXlzIHRvIGhhbmRsZSB0aGlzLiBBdCB0aGUgdGltZSwgaXQgd2FzIChhbmQg
aXM/KQ0KdGhlIHNpbXBsZXN0IHNvbHV0aW9uLiBUaGVyZSBpc24ndCBhbnkgb2JzZXJ2YWJsZSBw
ZXJmb3JtYW5jZQ0KZGVncmFkYXRpb24gZnJvbSB0ZXN0aW5nIHNvIHRoZXJlJ3Mgbm8gaW5jZW50
aXZlIHRvIGNoYW5nZSBpdCB5ZXQuDQoNCkJSLA0KVGhpbmgNCg0KPiANCj4gPiBub3RpY2VhYmxl
IHRoYW4gb3RoZXJzLiBUaGUgZHdjMyBkcml2ZXIgaXMgaW1wbGVtZW50ZWQgdG8gcHJvYmUgcGxh
dGZvcm0NCj4gPiBkZXZpY2VzLiBTbywgZHdjMyBQQ0llIGRldmljZXMgYXJlIHdyYXBwZWQgYXMg
cGxhdGZvcm0gZGV2aWNlcyBmb3IgdGhlDQo+ID4gZHdjMyBkcml2ZXIuIFNpbmNlIHdlJ3JlIGdv
aW5nIHRocm91Z2ggdGhlIHBsYXRmb3JtIGRldmljZSBjb2RlIHBhdGgsDQo+ID4gdGhlIHBjaSBs
YXllciBmYWxscyBiYWNrIHRvIHVzaW5nIGxlZ2FjeSBpbnRlcnJ1cHQgaW5zdGVhZCBvZiBNU0kg
KGxhc3QNCj4gPiBJIGNoZWNrIGF3aGlsZSBhZ28pLg0KPiA+IA0KPiA+IEEgbGl0dGxlIG1vcmUg
ZGV0YWlsIG9uIHRoaXMgcHJvYmxlbToNCj4gPiBQQ0llIGxlZ2FjeSBpbnRlcnJ1cHQgd2lsbCBl
bXVsYXRlIGludGVycnVwdCBsaW5lIGJ5IHNlbmRpbmcgYW4NCj4gPiBpbnRlcnJ1cHQgYXNzZXJ0
IGFuZCBkZWFzc2VydCBtZXNzYWdlcy4gQWZ0ZXIgdGhlIGludGVycnVwdCBhc3NlcnQNCj4gPiBt
ZXNzYWdlIGlzIHNlbnQsIGludGVycnVwdHMgYXJlIGNvbnRpbnVvdXNseSBnZW5lcmF0ZWQgdW50
aWwgdGhlDQo+ID4gZGVhc3NlcnQgbWVzc2FnZSBpcyBzZW50LiBJZiB0aGVyZSdzIGEgcmVnaXN0
ZXIgd3JpdGUgdG8gdW5tYXNrL21hc2sNCj4gPiBpbnRlcnJ1cHQgb3IgY2xlYXJpbmcgZXZlbnRz
IGZhbGxzIGluIGJldHdlZW4gdGhlc2UgbWVzc2FnZXMsIHRoZW4gdGhlcmUNCj4gPiBtYXkgYmUg
YSByYWNlLg0KPiA+IA0KPiA+IExldCdzIHNheSB3ZSBkb24ndCBoYXZlIGV2ZW50IHBlbmRpbmcg
Y2hlY2ssIHRoaXMgY2FuIGhhcHBlbjoNCj4gPiANCj4gPiBOb3JtYWwgc2NlbmFyaW8NCj4gPiAt
LS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgIGV2ZW50X2NvdW50ICs9IG4gIyBjb250cm9sbGVyIGdl
bmVyYXRlcyBuZXcgZXZlbnRzDQo+ID4gICAgaW50ZXJydXB0IGFzc2VydHMNCj4gPiAgICAgIHdy
aXRlKG1hc2sgaXJxKQ0KPiA+ICAgICAgZXZlbnRfY291bnQgLT0gbiAjIGR3YzMgY2xlYXJzIGV2
ZW50cw0KPiA+ICAgIGludGVycnVwdCBkZWFzc2VydHMNCj4gPiAgICAgIHdyaXRlKHVubWFzayBp
cnEpDQo+ID4gDQo+ID4gDQo+ID4gUmFjZSBzY2VuYXJpbw0KPiA+IC0tLS0tLS0tLS0tLS0NCj4g
PiAgICAgIGV2ZW50X2NvdW50ICs9IG4gIyBuZXcgZXZlbnRzDQo+ID4gICAgaW50ZXJydXB0IGFz
c2VydHMNCj4gPiAgICAgIHdyaXRlKG1hc2sgaXJxKQ0KPiA+ICAgICAgZXZlbnRfY291bnQgLT0g
biAjIGNsZWFyIGV2ZW50cw0KPiA+ICAgICAgZXZlbnRfY291bnQgKz0gbiAjIG1vcmUgZXZlbnRz
IGNvbWUgYW5kIGhhcmQgaXJxIGhhbmRsZXIgZ2V0cyBjYWxsZWQNCj4gPiAJCSAgICAgIyBhZ2Fp
biBhcyBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkLCBidXQgY2FjaGVkDQo+ID4gCQkgICAgICMgZXZl
bnRzIGhhdmVuJ3QgYmVlbiBoYW5kbGVkLiBUaGlzIGJyZWFrcw0KPiA+IAkJICAgICAjIHNlcmlh
bGl6YXRpb24gYW5kIGNhdXNlcyBsb3N0IGV2ZW50cy4NCj4gPiAgICAgIHdyaXRlKG1hc2sgaXJx
KQ0KPiA+IA0KPiA+ICAgICAgZXZlbnRfY291bnQgLT0gbiAjIGNsZWFyIGV2ZW50cw0KPiA+ICAg
IGludGVycnVwdCBkZWFzc2VydHMNCj4gPiAgICAgIHdyaXRlKHVubWFzayBpcnEpICMgZXZlbnRz
IGhhbmRsZWQNCj4gDQo+IA0KPiBpZiBtYXNrIGlycSBpcyBub3Qgd29ya2luZywgdGhlIHJhY2Ug
d2lsbCBoYXBwZW4gbGlrZSB0aGlzLCB0aGFua3MgZm9yDQo+IGV4cGxhbmF0aW9uLg0KPiANCj4g
DQo+ID4gDQo+ID4gRm9yIE1TSSwgdGhpcyB3b24ndCBiZSBhIHByb2JsZW0gYmVjYXVzZSBpdCdz
IGVkZ2UtdHJpZ2dlcmVkIGFuZCB0aGUgd2F5DQo+ID4gaXQgc2VuZHMgaW50ZXJydXB0IGlzIGRp
ZmZlcmVudC4NCj4gPiA=
