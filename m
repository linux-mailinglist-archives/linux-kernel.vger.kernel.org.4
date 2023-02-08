Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5668E544
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBHBKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:10:47 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458502CC7A;
        Tue,  7 Feb 2023 17:10:46 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Iju07002307;
        Tue, 7 Feb 2023 17:10:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=BQTpdGspCenauOSe/LT3z5VXBqb1/l51mrsDBaxCzmM=;
 b=JCusXLPXc4OklwwDy75ELAyp1f5LRP+qVVWlVgYAgPNPqpdKOEQz8D6NgU2+GAaE9zRJ
 Th0jdn7D3hSF8oxnA1L79rFWeNlzeGUVisVYtpu+WDWhLwc++a3+dWlNfwYSAIdOLfaa
 rhAJZOC/B1MUQBenGc2iDtDYKfVJ9eewFcu5XPWY1snEGeqL0ziMehHWSIERIpBDZIFj
 fneOwzxa1jNXIY2Ih7tT90qVsEUcIQ84ESEV7SlTruVjLHv1vy+Nhcc/NT4wQYqlPvRE
 +HdcZttRe/ULH73g1UvUhLTk2GN/TZZwXwlDYftAlTPcEXjtkMW1pnUy5Rs2iTnRL590 lA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nhqgby81u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 17:10:32 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0338CC008B;
        Wed,  8 Feb 2023 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675818632; bh=BQTpdGspCenauOSe/LT3z5VXBqb1/l51mrsDBaxCzmM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q0AZZ3AqNNeDeNb2NqqbPK+5mS4/tb/CqmsDzkjtPdsqeXkGrjZm5MCYtXVnS+T+V
         e9vrPwcWiBCWOv3zDZzFr0o6Pyq/pXW/MblQLeOzYWWEFzYl0q+YJlFMpTBGITF2Gu
         AwmupQRM/MOKcP7sEJhaIzU6eLq3+F8nojGFtQtvtX2CDb7jvsx/rUOJAo40/TldSq
         QnZYI3air1f6owwgQflWA991409YfNZQ+qohuOZM5DwYwedurGVdbwLbh498psmgx+
         uyv5Ksf0ZJUR0HXKpJa0crPAPoNRVveXvSrdElZS6rdOK1+RT8vyYMadY+uoAj0jrk
         nrhuDt29cWODA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3D4E2A005A;
        Wed,  8 Feb 2023 01:10:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B89D800C4;
        Wed,  8 Feb 2023 01:10:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RvulQ8Rz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju3lnLTpN7x+K5IwcPXe3iRGq5ZK1k9zTcHssu4AZDtoHmq0KJmZMZuMIw69OoQtd9hDroYTn15T6BepLuYZlk/ZBe361x+hL25u+d3y6CmWjTfyVHEnUBPeAeUwI3jCqO5A5xZhaoYuL+kxVYXLsE5tOAek84j6LEcvUQ8susMHdQz/SEbpw4sBn5bjcDbBUNeFnWNltDdQJpqB7hYN0obEiGP2amwHI58hiSmwCXdwC/WtX+m+jyhCaQ6Ummy7TvF0FBIdgComXxOJ8pXXlWYB0kKP3Hs8CHcucgainBMlJDgy1+Wm94eFUw3ApuFgvvIpM/RUrDmTa746UGG1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQTpdGspCenauOSe/LT3z5VXBqb1/l51mrsDBaxCzmM=;
 b=bXVdllr1eLHOW7g4aCZURXn8A9g2+TQw8/f7HYujDFQC1fAECQrsh4P3xAEwr1IwMkHh3R+NEd/VjfduoUSG7hufkX7GzF2GjyT+UxXp83YEl2dOIaIAD/e8CVjvh5+IvhwHM4qNkcX3LCoFMDPtW4Y3yTxqCUH3v2Xg5wUpHqkhOnlf46tXwXr1j8a/VpJWrv0lQrwamqITaX0cfGyAiCZEZYzjUxbsSixFNhc3Eag6WS/kU0NHc0adVUQBVl0nZCI2DIrWPNU8EyFGPds2mCGbFE+toU/AcVXdNAFD/47eweahgkjkm6wuNx8syv0xZc3hEU3z9h7KZDy60KILOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQTpdGspCenauOSe/LT3z5VXBqb1/l51mrsDBaxCzmM=;
 b=RvulQ8RzS57LWtLIXAiAqedJzM8k14HK4q4aNkSNdK9g6w6GBSAMlF4wYr0sL78pbHW1IMPct+sViF/FsbrCm9/CZaawNKdfdQgrlN1ryz5xEWY4wHYO38lk+lvNuRq+e0xloXwierTWPq57/cQgi/hfGjzO50q3WY5bzVYk7us=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 01:10:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 01:10:27 +0000
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
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZOl8gO3KZIGBpqkaJFw/1xTLpFK7CpxCAgAFu9ACAAClzgA==
Date:   Wed, 8 Feb 2023 01:10:26 +0000
Message-ID: <20230208011017.47o7m3xt63lbih3m@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
In-Reply-To: <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: 5316b2b5-4ad9-406b-3eb4-08db0971433d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1eHOKWssVz23dVEWGAAxHIwUYnQcKoc4K03IfSjuRBUyk7d7QEFrDJjOuktcrcQjrPDpbeMgowG/WW6BrZ50g40etJWcFKoQ+0g4ZfKuQTyJf1LpwB5+bd36WevA1Ol6GfHKEZgzBbya/RhhJIOgGo0uLDeyVLPqbb9rkO34SRKjr/6Qa3pCv1wQXzUZ235v8xusoJr4SpvQ+TefukxD7hCEe8iKvCv/UWI/Mo7ynweYP00VGInu/305guc3HJeoE7B7z8i5MwqOKH6zT3nOIRH40WpKzPRM8R9OQamnEeQHBVcQncTrG3Z6XGQtVjtydYK8bhcWwWovS86ciyQpxn6ft4b37gqMiovN6kbeiWyvBR7YxDlZdVHp59r+/zKRa3mtDQZYbAM6IY2T/LFCaFuKfd58iXMiI3Q/ZgYNDEF3GV2w61macRvGt4GKi66e4Yz13rrw9xTYzBYJI3v94J0Q9398yvc3KxESUODnLRiWHq0GaSP0eKQ9I5HDcSOWFX7+4dRzaQi5XrcO9PnUm0wn7lI0eM3U9QQ+HfgvhiG1Ij4JV62H+Q1X617i+/7sQHp4lzv3R9zMiE3S14400N4CoQxiy1HAx/HX95C+nuoM/MblK2tfzw4y5lSDFXkydpp3ps/jclqnY3OpBf+JSKlLGAoWwziHnhFNINbBPjYgUzl2SZgFPw5dZXuHDCLpRXonO8kYc4j+nJuYGSyXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(8936002)(86362001)(41300700001)(5660300002)(76116006)(4326008)(66476007)(8676002)(6916009)(66446008)(64756008)(66556008)(316002)(54906003)(36756003)(66946007)(2906002)(2616005)(83380400001)(6506007)(1076003)(26005)(53546011)(186003)(6512007)(38100700002)(122000001)(38070700005)(6486002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFrbGpuaVRtZ2MzTmxISU5uZVRxTlQwUUdka2VDYlh2S2FvazI0dzFxZFhI?=
 =?utf-8?B?N2hDb2ZVRGY5TkUrZ0dJbFc5TGtkL1lXNG5LMkQ0dXZPODdNbml3MnM3L1Bw?=
 =?utf-8?B?L2xIN210WnRwWnd1Vm9nYU02V1d4ZjlFMGt3cTE1andKWmFua3JNcGhFQVJZ?=
 =?utf-8?B?RlRPYTl1ZmdkT0xnTW1YU0lGUUxXOEtqVnJSUTM2bWlNZnBYYXp4cjVDb082?=
 =?utf-8?B?WWRMZE1CRVJ6NTVkNW0rd0Nlem11U3oxdGJqK3Qza21ycTBsZ3NCVGg5YWRq?=
 =?utf-8?B?dnNyVkcxejNmeW5UWGtJcEJXZmh6dy9UWXRxRHhzQmdrZ3EwWEpmK2tWL0dK?=
 =?utf-8?B?L012STFoV29iVzE2OUQ2Z1JZUDFZemxxTWN0QjhFSUM5VStIOXpDYXVoVGhp?=
 =?utf-8?B?b1JMdVZUemVWdkQ2UEdiaEpjRnRrVnVwcitEMlJQZTQ3cC9KWGl4QlZVTVRL?=
 =?utf-8?B?aHdvYlZEQW1YSm9FTFh1Z3dHc1dGQ1ZjTDFKZDdRTGRCTjlmMEJTbnQzRTN6?=
 =?utf-8?B?azFsbG5ZUUtPdXRZak1sR2RteXBEVm5zZFpaN3Z4c1Q5bDdVK3hyUDBqWXNw?=
 =?utf-8?B?T0pJWVJNaEpIcFJhb01MaXlEdU9BQ2xhVkNzRjVUQjVhQTJLaGwwVXFESERT?=
 =?utf-8?B?cVZpL0hnU3RBZXdjSUZmaC9ZdVU4UG1uUnhwWjRQTjNubUNQd2I1d1BJYStR?=
 =?utf-8?B?aDc3NkVqVnY4Ry9TVW1OWU1MQVdHeWhLeFR3TVpIRkE4Q0dweUJ5Q0l1M3lm?=
 =?utf-8?B?dllTRlB2SXVDRzFzZGNYa0Z1Nms1OVFHVENnaExFcUM2Z0wxQ2tiUXNzUXFK?=
 =?utf-8?B?YWRnYTNtQzVoYUJSYU9yQjFJU3BNR0hYRTYzYk1ZdE5TU3Y1Nm1kLzd6UUtS?=
 =?utf-8?B?MTF0cUdjNnI2SG9JdXBSMzQrSWo4bDl6aVhralp1dUV3UnZVRnd0Y2FjbTVQ?=
 =?utf-8?B?Yi83bEZOTnBFcU9SVW82aW5zRjdqUVRSVW11Sm5JOWNxSnBLMlFwYTBRdTI3?=
 =?utf-8?B?Y1N2TUxNOWVzZ01sU1NxM2tOOTRLM2lTWXJEVEhMZGFNdFk0Q3VWYXNMUHFX?=
 =?utf-8?B?SW5rTFhsWmt5dXJJbEpQTStDU2JDeWlXb1UxazJhcWptQVdyVXFGYW1rWkd5?=
 =?utf-8?B?b291VnQxbnJiaUFvYlE1eVZDZjlQT3lXYUpLa2tXdEVDNG9OWld0cTY0U2VX?=
 =?utf-8?B?ZVJTTS8ra0xQaFZwNE02SmEzVzMvZ25IZ2lBV202bFB3SFFlRWFlZ2dlUTBr?=
 =?utf-8?B?TnhCYWVZM2RZcFl1OWtRZ20xMFRRUHkwby9XclVBV0N4SGZIbytlem1XZDRX?=
 =?utf-8?B?ZCtEdVdGaFFXTks1UmVUK25zMXZFdm1QK0Y4Yk43K0krZGxZOURmSGVLVUhW?=
 =?utf-8?B?ejVUSStaR1l4V3E0anlRa1lzN2pVY0ZraGZraVQyWmpkUUtMMGJ5ZlpiOENn?=
 =?utf-8?B?YTk0dXhxT2QzNFVDTVozL2NISlZQVEVmL29HMldoeXI0eVViblhGdUtjM3M0?=
 =?utf-8?B?K2tXSWVOVmFGcG93QUp0UG8zTFpMNXEwdDVuNm1QWVVzYmx0bytkeFRTNlcx?=
 =?utf-8?B?a0QvbTJEZmw2d1crMEpOdWttWGRhNHlMMlpBTUpadnZtdllFVHBhZm5QVjZa?=
 =?utf-8?B?STJYUDZIcHZCcTZRcmhUU05SOVpDT1p1OEk4U0NxOW1UR1JNa0tGRVBXYjJO?=
 =?utf-8?B?RzhWMUlxVzRWek9LV0xjZktIVmtSVlEyUi9pZlRsRDJBelJzcUlYZ25kUVJJ?=
 =?utf-8?B?TlFUd1B6STVhOGVnRlA0ZGRmSVplc2UxMFZSTUdkeXBqcmRDUXFwbWxYZXk4?=
 =?utf-8?B?Q1dPcVRHM3JWcmFZc1J0cGlIQko3TjNJM2d1SHVPSVVORzdKUTFEbkFGWVF5?=
 =?utf-8?B?ZllaRkdyOVF4UGx2bGRGc0JiY2dWZk80UDNYcTROUGVJQUdkR1dmUDMzNmdK?=
 =?utf-8?B?bUxkWFFsOXkzOHdWSVZtbE81R3AzWE1aR25JR2ttN1BTOVR3cWd0SjllL0N2?=
 =?utf-8?B?bm5wNkJ0MnFBT3owL1RldUxGZDRRVEFBUkhncFNmcFdCYlJXdVVpcHFacUhp?=
 =?utf-8?B?S1FpdzQ3VTZOR0tUblkxTWlhVDVWWEpYckZ0aHBsdS91Mkh4NG56WkxUcnRu?=
 =?utf-8?B?WE1TMnBUdjVkd1NlQWRkMHl1aDMrRVUwN3VmaExVbHpvMFU3VnBxL2srYXQ1?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DFB00C42C24047A037074D6D8DC21F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ImeNpAg6IG05+0mpBlS3DAC48V0pMUfxmhKvgkkldN0GjhJFn72o2aCTJV4QNhsKi/MTLzmgDAUYr0iUMsUG6WEX+Tj11IfMnpQrkHhUS/FEtiXU6DTck48eW9ASHRWvny5nHlgWJrGYzmMdY3LWJS/aMPUyoWdAST+IIpj5he4kEL3vTTGrjMXbsmz8j7JKHLmRjiNN+ATXPBbFYMwgYSfWKr3dSKQW0rz4CxJEoFRgprMiW4bWHeWzFjE5EbWtNwd09/B+8nhFV1LABAO2O6M/Z9itXglDM41A0XsJyo+jwkL28WjyQZlkr9gRu0SoBTZgH4ZPbR3jr9owXfGNRh/8xXk86LpzFmALcgRMzJdPGFb3QY/ukmxZEGyRO517U4c4X04MeKMQbsJCaiJ7oHA0m1+su793K0uvtPeIaGSxzIHmo1V3r23+CfQWr59h2x4hZcQQAeQQy43MRYsoNrUZG94+DSi568K7pDCiC4ExtQrJ7/GJ9s/ukXNgAbnCU62RoA1GDEI96e7t8Mw9rTl1Sobp/p5A5rCgeJsyF9pH4jITixXF03e3oqj5g9/04NyT6QXBdrdQ1N4y8S3IcxNG85CWBY4NWJQje2Cmdpazg/M7NYxy0V1Rd83HzZhqD4p9ui8FQn8WoZHBGwl8b1mekUkP7EBAB2Uh9SvqIxtshShvBlyZD9B3RFmldHI60g4ipxoNgIgmnueibSFgINRhqDFPabE7LV76J6xAowkLnD6rS/qo4tgLvY2C+kQTUZJW0hTBQ0WRC8WIi2rGwMtFzazWQpXVPI5e+i/2ZVslsvm17Azl21OJO8xkdw0zZGzNO0R6MGyM/is3UzAAJ0jIUTxZXcaJK0+Nw7UXLuLmHNvs6eGgFJUg+9BR+flYDH1wvmXl9/M1r6dEv1QrzhAPyENvTCQ+TGBdYcKeiXE=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5316b2b5-4ad9-406b-3eb4-08db0971433d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 01:10:26.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukeEFYVVVoVjewJkH8KYFhdpGCTujEizb2vgX8Ot8W7pQy0tUWc+juDjNAOctrIlJP696Iaw89KR0VCU4mzP8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
X-Proofpoint-ORIG-GUID: W3ZrMaW25QnhbcMhFFKAsYbgQRlSG3sy
X-Proofpoint-GUID: W3ZrMaW25QnhbcMhFFKAsYbgQRlSG3sy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMDcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gT24gMi82LzIwMjMg
NDo0OCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gK3N0YXRpYyBpbnQgX19kd2MzX2dh
ZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YywgYm9vbCBhc3luYykNCj4gPiA+ICAgew0KPiA+
ID4gICAJaW50CQkJcmV0cmllczsNCj4gPiA+IEBAIC0yMjk2LDkgKzIzMDksMTQgQEAgc3RhdGlj
IGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gICAJbGlu
a19zdGF0ZSA9IERXQzNfRFNUU19VU0JMTktTVChyZWcpOw0KPiA+ID4gICAJc3dpdGNoIChsaW5r
X3N0YXRlKSB7DQo+ID4gPiArCWNhc2UgRFdDM19MSU5LX1NUQVRFX1UzOgkvKiBpbiBIUywgbWVh
bnMgU1VTUEVORCAqLw0KPiA+IA0KPiA+IEl0J3MgYWxzbyBwb3NzaWJsZSB0byBkbyByZW1vdGUg
d2FrZXVwIGluIEwxIGZvciBoaWdoc3BlZWQuDQo+ID4gDQo+IA0KPiBUaGUgcndfY29uZmlndXJl
ZCBmbGFnIGhlcmUgaXMgaW4gY29udGV4dCBvZiB0cmlnZ2VyaW5nIHJlbW90ZSB3YWtldXAgZnJv
bQ0KPiBidXMgc3VzcGVuZCBvbmx5Lg0KPiANCj4gVGhlIHJlbW90ZSB3YWtldXAgc2V0dGluZyBm
b3IgbDEgaW4gSGlnaFNwZWVkIGlzIGNvbnRyb2xsZWQgdGhyb3VnaCBMUE0NCj4gdG9rZW4gYW5k
IG92ZXJyaWRlcy9pZ25vcmVzIHRoZSBjb25maWcgZGVzYyBibUF0dHJpYnV0ZXMgd2FrZXVwIGJp
dC4NCj4gDQo+IFNlY3Rpb24gNC4xIG9mIFVTQjJfTGlua1Bvd2VyTWFuZ2VtZW50X0VDTltmaW5h
bF0gc3BlYyAiVGhlIGhvc3Qgc3lzdGVtIHNldHMgdGhlIFJlbW90ZSBXYWtlIEZsYWcgcGFyYW1l
dGVyIGluIHRoaXMgcmVxdWVzdCB0bw0KPiBlbmFibGUgb3IgZGlzYWJsZSB0aGUgYWRkcmVzc2Vk
IGRldmljZQ0KPiBmb3IgcmVtb3RlIHdha2UgZnJvbSBMMS4gVGhlIHZhbHVlIG9mIHRoaXMgZmxh
ZyB3aWxsIHRlbXBvcmFyaWx5ICh3aGlsZSBpbg0KPiBMMSkgb3ZlcnJpZGUgdGhlIGN1cnJlbnQg
c2V0dGluZyBvZiB0aGUNCj4gUmVtb3RlIFdha2UgZmVhdHVyZSBzZXR0YWJsZSBieSB0aGUgc3Rh
bmRhcmQgU2V0L0NsZWFyRmVhdHVyZSgpIGNvbW1hbmRzDQo+IGRlZmluZWQgaW4gVW5pdmVyc2Fs
IFNlcmlhbCBCdXMgU3BlY2lmaWNhdGlvbiwgcmV2aXNpb24gMi4wLCBDaGFwdGVyIDkuIg0KPiAN
Cj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuDQo+IA0KDQpJ
dCBvdmVycmlkZXMgdGhlIHNldHRpbmcgb2YgdGhlIFNldEZlYXR1cmUgcmVxdWVzdCwgbm90IHRo
ZSBkZXZpY2UNCmNvbmZpZ3VyYXRpb24uDQoNClRoZSByd19jb25maWd1cmVkIHJlZmxlY3RzIHRo
ZSB1c2VyIGNvbmZpZ3VyYXRpb24uIFdoZXRoZXIgdGhlIGhvc3QNCnRyaWVzIHRvIGVuYWJsZSB0
aGUgcmVtb3RlIHdha2V1cCB0aHJvdWdoIFNldEZlYXR1cmUgcmVxdWVzdCBvciBMUE0NCnRva2Vu
LCB0aGUgZGV2aWNlIHNob3VsZCBvcGVyYXRlIHdpdGhpbiB0aGUgdXNlciBjb25maWd1cmF0aW9u
DQpsaW1pdGF0aW9uLg0KDQpJZiB0aGUgY29uZmlndXJhdGlvbiBpbmRpY2F0ZXMgdGhhdCBpdCBk
b2Vzbid0IHN1cHBvcnQgcmVtb3RlIHdha2V1cCwgd2UNCnNob3VsZCBwcmV2ZW50IHVuZXhwZWN0
ZWQgYmVoYXZpb3IgZnJvbSB0aGUgZGV2aWNlLiBGb3Igc2ltcGxpY2l0eSwgd2UNCmNhbiBqdXN0
IHJldHVybiBmYWlsdXJlIHRvIHdha2V1cCBmb3IgYWxsIHN0YXRlcy4NCg0KVGhhbmtzLA0KVGhp
bmg=
