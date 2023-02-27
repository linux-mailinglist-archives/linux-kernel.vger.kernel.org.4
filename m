Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA46A4B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjB0Tue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjB0Tub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:50:31 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E66241E0;
        Mon, 27 Feb 2023 11:50:30 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIsJvE013020;
        Mon, 27 Feb 2023 11:38:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=dCVPrl2ALchjRPeRPkHTfOaXne1t92OmEt31MGMXIYY=;
 b=R5I3K7J6s+oFsPdkEnSoiUhHUv2nDsxSSkdmldg7KJTjsHfVeeh5lL5JDy981bvbUzMT
 TMb7jCVelovivjflS/b5zBjKfoGpUS+VPMIruzFN6tGNSTl9qIJ6QnnKEb/Z+0LYK8F3
 4bHVgiFHnsxMbOZDjGLTPltz/O4Cyzj2ReNheFIQDfcEuGRCgJoDcV22B0rwW3IANTI+
 KHsJ9n2luWMW6mGvemw8L60gWYxDQJ5hjA8fmbHZHPXRIl81KQqYdzBzH8rLChUqulmi
 sluJ4N6iju5ckUcyvIjc3rDPU1ID33egSgJfO+BJEAtuHhYvOXkk8vQNyphZzlGKDDOd ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3nyhumd1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 11:38:50 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D2AAD400BA;
        Mon, 27 Feb 2023 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677526729; bh=dCVPrl2ALchjRPeRPkHTfOaXne1t92OmEt31MGMXIYY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AH3BfwGlsl/X7ecCQZ8Q53e39gK9Cnbdt8CDE9WI2l/lhkleYc+Bech4pw1nQdKqH
         NhW/Ppns7GHMyudRAbrRfTRFChatJT2N62yAZ+qk8mYxfacLvKFKhii9gzp6blvOl5
         /IzI9b7XV0q00bnr9/6MpttFTwi7z9tbykN+RCcJ7H/nPUCTtAMGZ0w9B7+aYZ1y7W
         fLyLGT+dN2dsOgl+T/BAlQp8PYcUsmrXIHDjANna3zSs2r6UHrIjj+qK0atk4fMTLP
         2nIe9puAwM3eTsTqWw7jLQKX8R8wg5dPGrINSbOtOlifgLhQLZYBjHDM+ToPxbmO05
         jZUUYA4F2aoHg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2A410A00B0;
        Mon, 27 Feb 2023 19:38:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4F16C400CB;
        Mon, 27 Feb 2023 19:38:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dDk+E1xC";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB1D0He552vLcFA6U/8NtLzv/8Aiw2xpHlARyH8qWsc9lvWWO8AwzmZheIVDx8Sj+lbfle+4ThtB33gU42qGd8PxSfUJWaezvu0Mm70ReswV/tiMdB9vQnNiplQHAnSZ4+UnAEkCHX+dpsUDSxStHNs8LL0kqBHNoihSTeH/1W0WhxG8nSxNhyuoo1wNDAM2jMFANrMn8x89yp3nL3v8J1CD/xoq2jgBPCpiJW/hCKg2oLoPBjTXEKtx/lweJRj5hRWljh5hbT65U1KyzBmsTXmhRP225Y4hQ2GsGPFQwLCqPnqu9pBlKrR4+lc1HKxqrtz/uhY+YFe6u3GPopHGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCVPrl2ALchjRPeRPkHTfOaXne1t92OmEt31MGMXIYY=;
 b=AYCDu2k/t6pbTIvR3ZhRV9zfzy3Cz8AcdCszO7NAoSlXOf6PZhBwqQiKJCVMtzEfHoh0DoPVRUCcuy6KfsuhoKGo0pxVbz/sbk4REEzIiah3erv5SQkWmPpTFKM50VfgYocDBvoF6W7rwMk2pgaa4hX+zmmnpjDWJZw6b00KHnVLciGZrZSwRm03dzaN1+o9OZ4BvxPoRi67SWc//sCs32brhS7KoHjM6oCRUKWJuCPltZG3ygF3oOtK0mLU1il6j3PUL9SMRrnsGIHKogXJLmiUsQPm+2i62Jq5F8PUawmFo2bkB3mkxC2egAc4TeR4i2fk9PToAnQS7uTUg5djhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCVPrl2ALchjRPeRPkHTfOaXne1t92OmEt31MGMXIYY=;
 b=dDk+E1xCmKfHQ3FLyZ6W9yQyOWuaFzDw6rdnqXad66lu1t4S+a41l6ZVFrAWJMZr4uKF4NA2Bx0U04xHq4Yu3pi5/HA0sxWFAM0dIlFQGfAOUz3VcvYZjI855CY7OmhokoKlifsoAY3WvHYW+W6iiFA/UM5FNhiZKBxMXA9vLYE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 19:38:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:38:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Topic: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Index: AQHZR4RI6tyX8XGkuEOVkCA1IEksoa7c9quAgACTUYCAAOVcAIAAyDUAgAP/mQA=
Date:   Mon, 27 Feb 2023 19:38:43 +0000
Message-ID: <20230227193840.mygvoxz7soklf4vm@synopsys.com>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
 <20230223201019.3a5njywzchztcs5e@synopsys.com>
 <3a189c0a-e82b-a80b-ac63-0f2c703b2eaa@quicinc.com>
 <20230224183830.ox65eocunuvlp7zt@synopsys.com>
 <3a69b51c-9e2a-2d36-27cd-2619f9e3a356@quicinc.com>
In-Reply-To: <3a69b51c-9e2a-2d36-27cd-2619f9e3a356@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB8746:EE_
x-ms-office365-filtering-correlation-id: 2c3a1f3e-68ea-4c46-56b5-08db18fa3c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0Dt9R4wc1aPK+V/v7V7S8t0pIrejwoPPRLTWzxmixSpwWKsYvQicuurQJfVzCcyP1YMLdJPbhq3u0pNjA/tmEZiR7pFyz+WJ1eMd5j5bzmjDwGze2T31uFB4NREf9W6ZeUfo8RnMsfN5Y3/QuNzKSQNCFPeJ2EUC0AyE2pjfgiIog/jsFdY25TThcnbM+WkDTXBXTFGXq48c0qiiAW2/KNwRWRWGU5RNuqsZMcB6E6mUcK+XGJ/rZuSwNuzDriBhkgS3yOheE6cTMjbeMict/YBR9xA7Rxex+8teT/jqubunE8GCb+sYbtSw31tTEvYaWg5JuYAqAGpmBfVn5309JT4OdfJRWNlAnA9xoqmaxP4vpHmA1UN6X5bIro2Xn9Wu37XW8hqsGJflcfxxpZiqqU9q28JBctl310taXZ+Oowoux+MK6fDX22Tr+OmKYzwJ2MhSnbBegB72l158okRGMfdCpmn5NEuOPDBNL4V3eOgSCJTibEjdTX2OdqN5lwJcjvGMEWjmkdUdlkkumrzatq4v6JFNFjkazNVKd5reDqqlZgdmPM8EK/jY8lNDjuGwg1/VXXfMQNmH4Y5QGYh7dd5L03wJuIsMOXEkQSycwlJU2wzgPEYQizGxXgJpanWFay/uuA0Zy/SFH3/L+raXMumUKJGJxZp1EjUYBswljCnhvZ3XkAPszTPidXAKcguhtVNHglCox9wInEUVH2DVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(71200400001)(478600001)(66946007)(4326008)(76116006)(66556008)(8676002)(41300700001)(6916009)(64756008)(8936002)(66476007)(66446008)(36756003)(38070700005)(86362001)(6506007)(186003)(26005)(6486002)(53546011)(6512007)(38100700002)(2616005)(122000001)(1076003)(83380400001)(2906002)(5660300002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGtIOUN6WTNSTndjMVFraFVUR0Y5dmJNQlI1NTFFclcrOXdWU25PNnUyTWVh?=
 =?utf-8?B?T1lQVWxPVTJwc25yMjZZbDdzTEJtRVBzOGtUQUM2eHI3c3crT2ZJNjUrckJp?=
 =?utf-8?B?dHk3cUsxd0dMU3BJNTZpZFc2V1dSakhkTkJITkpoMklEM0dVcFBEZ3QxTGxX?=
 =?utf-8?B?czNsUm1KZGQzTDhDbHNaTW5KSGl0RktpWEJIKzdWUk5GTDhwS2xjczVRalNK?=
 =?utf-8?B?Q2pqWGt2S1VpT3NJT0hnYitBL2MxT3podW1iZUQ1UGRINjZBcnNTYWprM09u?=
 =?utf-8?B?WHNidzd5c04yMUVDbGVnMEJpbkNUZXhLajJHeDROeFBMcG50WlMvMzhXbzJv?=
 =?utf-8?B?RHZkcHZYVDVWUWR2ZStONVRmZGMzNisrazdqKzZWSkpKcVJiV2U5SXJETm5I?=
 =?utf-8?B?bTkzNTdPWGNmbWhmWWtJMm95YWV2bG03TXBhdFdIWnB3a3ZOcWl3M2R3WnI0?=
 =?utf-8?B?QWJTOUVXbXJyYmVROGVBZE1UekkwMlpSY3pBekFVTVFwNXZXd1h1dTRvWjc5?=
 =?utf-8?B?ZlB6UFFqeGI1bXF0SE9qSllpTlBnaFpEWEN6SXNkbERJL2M4KzlDQ3gyRDcv?=
 =?utf-8?B?MzNQOFBLalEzTEI2TnYzNkt1RWJKU0NQVndadDdoUVZkTzgxS2gxWXhLLzhE?=
 =?utf-8?B?VDNxbDQ0L1JqRDhiTzM0dFN1OE52dGJNTlBiYTBuQzZ2blMvY2FaQnhJRVBK?=
 =?utf-8?B?KzJZeTYwN2pVSEtpdVcwNTdkSmlOM2JSKzZDT0ZOSmxZTXlYckhOb25UaU5F?=
 =?utf-8?B?M1IwSUF3N29NRWt0S1ZjRzRJMCtCT1VMVXhwb1VGWkxBaCtUSWw4SGNCWmpt?=
 =?utf-8?B?bjlFbUV6bzd2dTRTeXpuRlM1b3AxNGdBVThWVWhSOVpTenVMUE1kTWdRc2tD?=
 =?utf-8?B?enZ2T0ZOOXFRVFZHZnJBNzJoekxNMTdYUGVRZ2xqS0ErWmdOemFmMDV4L3FZ?=
 =?utf-8?B?VmJIQVRUNG9rLzRtSFp6emNYZWJxb3hQd3NxWmRJVWp0YXlTYzJuWk52WWdn?=
 =?utf-8?B?QWZrZXhQeTJhQ0hJb1FpcVpWZ3hPWjRBSGgxbkRXTjBwbWhiTnFabm9ZbzZK?=
 =?utf-8?B?UVI3bGFqYXJZWjVtWW9JZGk1Zk5veGErNFVoQWZVcTJWU2RQMXgrMFBaUjBC?=
 =?utf-8?B?Szd6Zytpb1VEUGgwYmlYTE5BME5LbFdQZThPQUhwS090dUxOd3FYazR4NEJD?=
 =?utf-8?B?ZWt0ME9zWmtzbkRnRHlsNmh4Y0RFc1BRZkozdmVTeFRjM3J3Zi9RQU85dmZh?=
 =?utf-8?B?ZHgwRjhFUzlSL1N2aXFzUEdvalhzNG04MTFtZUtlaGQ2QkxvVG9kNDdRZERG?=
 =?utf-8?B?MFN1emQwYVlrTXN3WHJmQkRGTmdUdjlkT2NjTGlVVVh1c09jUFo3ZCtpNmsw?=
 =?utf-8?B?OWlmaUovejF1blY2eHZQVWVvakNabFpSUTh3YzlVb2dTeG4wRG9KejNuOEN2?=
 =?utf-8?B?ZWVHbkV4WWRTWmNzQ1RIZEs0MENoZmdURlZ0cFk0UXhQdEFwb0tpYzlZZmI4?=
 =?utf-8?B?NWwvMVowVFY5QXFURGpQNUtNLzhlZkVhZjRLckRQaHI0a0lHcTRDSGFvSWdC?=
 =?utf-8?B?UjU2NklLSXhCYTRUQ0pTVytxaXp1TitUa2Q0UWVEVmw2eVlhUGlyTTJFdFkr?=
 =?utf-8?B?SElxOEl6T3N5Mk5MOFRuZUtjekx1Z2t3Q041TWY1VHRkY2djVjhmejBRR011?=
 =?utf-8?B?bkFyRUxCUXFNNW1jNGxKV3ZUMStnT2hwZVJyUG5OblZjVHVac25rendVMWJG?=
 =?utf-8?B?eTY0K1FHbnJTblVIeWJhOWZDTnBqS0JNa21YM1BwalA2OThGdmg0OVA1SWdN?=
 =?utf-8?B?UkRpQlZjTGsvUVJPeG8rNDgrclV4TEhqRWp5NXRZQjJVK09uZ2xpRXIvZmUw?=
 =?utf-8?B?b0NaWGRGbi9COVViVTJGZjFqY2E1UXJyZkFJaDNFR3QvYktuUlAwNjVWZkVK?=
 =?utf-8?B?SURLZGgvWmVVelpMWUZnVHgyditxaDd4MFhtNFB1S0JXMFhCMU9RcGhBK3lX?=
 =?utf-8?B?WTJ0WjVJN0NYWFhrcXlIYWt0TEdkSUxWa3FZVjdWZVBSN3cvMjhPZHJLZE14?=
 =?utf-8?B?amNZT1hDQzdxdUNYcERjOUY4UXRBUUpQOW00NjA4L1pGcUNkUXlPand1anJy?=
 =?utf-8?Q?iyBJWXFm99W5Hr92lv+q3H50s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0511AF5080C71C438B93FC879F762FE9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bk9DbGFKYy9EdFd4NDJCNkJGZVQzcVNDNk55N3MrcVdyNlRCUVFETEpNNms1?=
 =?utf-8?B?QUxmd3Z2VWNObU5wQVY3UEJremtpR2xFNFNxbWI4eGMzM1ZnOG1QblZXUVdD?=
 =?utf-8?B?VGVlTzVpUk5rQkR4UzFpYTRBVlIvbnN1SGIzbFJrTy9SVkZHRWpZRGh2SEth?=
 =?utf-8?B?bGErSy8yTVJndkk1emROM2RIa3U2NitvTytWaXhGL3dQa2E3eEpLUHFjSWR1?=
 =?utf-8?B?NGNwcGN2Rm9ZSHlSdk4xallsN2NORW1qZ1RZTy9kZFRmTWsvdktybUJraHpx?=
 =?utf-8?B?YklDV3JOb1M1VGhZQ1BXWmVoUFUwd1NWaHFsY1AxbXVxZnBTYTZyU3A0VWZO?=
 =?utf-8?B?akJSOS91L0szSzZ2aVZsdTNSdklLdHp2WDBDWmV1TzdJM2VWTHBRNlNXc2JC?=
 =?utf-8?B?MTNKL0gwNzNiZFRDZG5kZ1NEOHJ1K0VNb0dGL2pEeVJobFBrMnBUUGVCMzJL?=
 =?utf-8?B?OWZJQTdWcXY4RDEzL1dxVWNDb1phTFM2UkRmWnFqb2Z5VFRxWVhHdlFzWS9I?=
 =?utf-8?B?WFV4V2RyM0swaGEwVmdtVHFHaHBzc2ZlYkVSazI3aWN5Tk1XdWNiQmk0RExU?=
 =?utf-8?B?c29IZE8wU0tMdTJtZ0JaMkR0dHdueDJ4dEJURU5ldWIzb25QQ2tUQktvdlBO?=
 =?utf-8?B?QWkxOC9POGRXWldOQUFEaWJHWlRsYnlINFgwNDdacUNWTTFqbHlrZFF1UE9i?=
 =?utf-8?B?WGxBU09TTldLL1h6NmJnY3JQOStleTBKenQwTm1QTU5Oa2FBUDZMUVQ3dm9y?=
 =?utf-8?B?NUhXK2JXamx6VW5mRjBzWjRjckZBTWdrZ05mUmpLZG5OMHBSdGtKa29Ta2E3?=
 =?utf-8?B?QWFQOHRiMnE1aS9NbTBPT3kxUmkzTWtZT0FUQkxqWmJmbDgxSXQrQzdMbklN?=
 =?utf-8?B?OEF5ZG9kZ0Nla0lLUlpSUVRGeEgwaGx2cE01UzlEQ0M1OE9xcmc2RlFyeUJQ?=
 =?utf-8?B?YjhUcXMxcGIzSTJsSVlrMlY4VlQxWU5vamhQQnhpMzBUUWxyS1BjUnM3cDZt?=
 =?utf-8?B?YkI0aUVDUHBNQUE4MWJ1bkgwMnZUOTBZTHNGTThZRXBnTFdTeGxVRWNEV2VW?=
 =?utf-8?B?MWxPUWZUQm9zRlBadlByZ3YxcHdZS09ESEVodEh3RElETk9zN3lDQW9mQUZV?=
 =?utf-8?B?SDdGaVlidnl3bkRjV1AxSjZ1V0xDbUJqNlBQc0U3b0lLV3lZdk4vNm9rUU1q?=
 =?utf-8?B?SytYSDE4VllpaTVuNXFFVjR5UkpZRUN3R1pYc1FqVDFvdHZTWGR5clBQT3d0?=
 =?utf-8?B?dFEyOTBTd2o4aWljRnUxQVFtRWJsUHZOSjdHVjFySWY0R3d6UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3a1f3e-68ea-4c46-56b5-08db18fa3c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:38:43.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5a1AhGsT2Zzhv26Kf5hg/TOGCcccB+ylTOml5LvjSFAHUKgKtKVqGgptlDYY16hamvgO7OMNi7hU8dzqYicpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
X-Proofpoint-GUID: _Od3TO-b6YlQJ0uBWwI-5VQwZzLhr2Be
X-Proofpoint-ORIG-GUID: _Od3TO-b6YlQJ0uBWwI-5VQwZzLhr2Be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_16,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=599 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBGZWIgMjUsIDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDI1
LTAyLTIzIDEyOjA4IGFtLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJpLCBGZWIgMjQs
IDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDI0LTAy
LTIzIDAxOjQwIGFtLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgRmViIDIz
LCAyMDIzLCBQcmFzaGFudGggSyB3cm90ZToNCj4gPiA+ID4gPiBDdXJyZW50bHkgd2UgZG9uJ3Qg
Y2hhbmdlIHRoZSBjdXJyZW50IHZhbHVlIGlmIGRldmljZSBpc24ndCBpbg0KPiA+ID4gPiA+IGNv
bmZpZ3VyZWQgc3RhdGUuIEJ1dCB0aGUgYmF0dGVyeSBjaGFyZ2luZyBzcGVjaWZpY2F0aW9uIHNh
eXMsDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91IHByb3ZpZGUgdGhlIHNwZWMgc2VjdGlvbiBh
bHNvPw0KPiA+ID4gPiANCj4gPiA+IDEuMiBCYWNrZ3JvdW5kDQo+ID4gPiAxLjQuMTMgU3RhbmRh
cmQgRG93bnN0cmVhbSBQb3J0DQo+ID4gPiANCj4gPiA+IERpZCB5b3UgbWVhbiB0byBhZGQgdGhl
c2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPw0KPiA+IA0KPiA+IFllcywgaXQncyBiZXR0ZXIgdG8g
aGF2ZSB0aGUgcmVmZXJlbmNlIGluIGNhc2Ugd2UgbmVlZCB0byByZXZpc2l0IHRoaXMuDQo+IEkg
aGF2ZSBhZGRlZCBpdCBpbiB2NCBwYXRjaCwgdGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQuDQo+
ID4gDQo+ID4gPiA+ID4gZGV2aWNlIGNhbiBkcmF3IHVwIHRvIDEwMG1BIG9mIGN1cnJlbnQgaWYg
aXRzIGluIHVuY29uZmlndXJlZA0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhpcyByZWxhdGVkIHRv
IGJlaW5nIHNlbGYtcG93ZXJlZD8NCj4gPiANCj4gPiA+IEkgdGhpbmsgaXRzIGFwcGxpY2FibGUg
Zm9yIGJ1cy1wb3dlcmVkIGRldmljZXMuDQo+ID4gDQo+ID4gTm8sIEkgbWVhbiBiZWZvcmUgY29u
ZmlndXJlZCBzdGF0ZSwgaXMgdGhlIGRldmljZSBjb25zaWRlcmVkDQo+ID4gc2VsZi1wb3dlcmVk
PyBTaW5jZSBiZWluZyBzZWxmLXBvd2VyZWQgbWVhbnMgZHJhd2luZyAxMDBtQSBvciBsZXNzLCB3
ZQ0KPiA+IGNhbiB1c2UgVVNCX1NFTEZfUE9XRVJfVkJVU19NQVhfRFJBVyB0byBwcm92aWRlIG1v
cmUgY29udGV4dC4gSWYgaXQncw0KPiA+IHRvdGFsbHkgdW5yZWxhdGVkLCB0aGVuIHlvdSBjYW4g
aWdub3JlIHRoaXMuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRoaW5oDQo+IEFzIHBlciBteSB1
bmRlcnN0YW5kaW5nLCB0aG9zZSBhcmUgMiBkaWZmZXJlbnQgdGhpbmdzLiBBIHNlbGYtcG93ZXJl
ZCBkZXZpY2UNCj4gaXNuJ3QgYWxsb3dlZCB0byBkcmF3IG1vcmUgdGhhbiAxMDBtQS4gQW5kIGFu
IHVuY29uZmlndXJlZCBkZXZpY2UNCj4gaXNuJ3QgYWxsb3dlZCB0byBkcmF3IG1vcmUgdGhhbiAx
MDBtQSAoaW4gSFMpLiBPbmUgdGhpbmcgdGhhdCBJIHJlY2VudGx5DQo+IGZvdW5kIG91dCBpcyB0
aGF0LCBhcyBwZXIgdXNiMy4wIHNwZWMsIFNTIGRldmljZSBjYW4gb25seSBkcmF3IHVwIHRvIDE1
MG1BDQo+IGlmIGl0cyB1bmNvbmZpZ3VyZWQgc3RhdGUuIFNvIGkgaGF2ZSB0byBjaGVjayB0aGUg
c3BlZWQgYW5kIHNldCB0aGUgY3VycmVudA0KPiB2YWx1ZXMgYWNjb3JkaW5nbHkuDQoNCkkgc2Vl
LiBUaGFua3MgZm9yIHRoZSBpbmZvLg0KDQpUaGFua3MsDQpUaGluaA==
