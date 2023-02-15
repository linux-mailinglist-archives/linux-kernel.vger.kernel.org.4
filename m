Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1096972EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBOAzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBOAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:55:45 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335EB2CFC4;
        Tue, 14 Feb 2023 16:55:44 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0fa6Y016764;
        Tue, 14 Feb 2023 16:55:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=38wFCJCrK8SUgxERv5NqHgGiQRwn0PD7FQ5ua9KaVgw=;
 b=KJcIRJDE3fEdx+jgmYv4ONEcvOiPSN7O0e2rJZ4CHn7fHipYZjHB4+A5mSUVC+G3y6MZ
 76o0hVKnQQpwIeGqEq9qgMo0J+IpxqhlZ6Fw8vdI1Cf1LtLSgA1IwG6n1n5gkecxKTbN
 IwCNcHtB5w9cPikcWO77d0BGfmwHpF3iV+yl9S3z7B/QrHoOubHgE4CPpMKXSQt10iXk
 tBnGP5DXuMgD73h2FJpMcqDGC8HrdpRFrNwR/kRlPw1z0sFbgpBBMxt0qcmRjUVK8IA4
 0LSPNyLpBmKYan43Qf2rZuZTkbjTUJzZFVCoy0xxjQ/fCKUC7jK9VP7DJUn554nL8uhL 8A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3npahm4pd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:55:32 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DA9EE4008A;
        Wed, 15 Feb 2023 00:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676422531; bh=38wFCJCrK8SUgxERv5NqHgGiQRwn0PD7FQ5ua9KaVgw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IGkCSNndCC3I3i2OdvlqUMXBtbTGt7vSpWliVU5yFQQcFgHX4zynZQwuQo9rdl6qS
         TdKjNWu8dcBFi5Uvk3gGzWWamU1VhnEM1iybeJONX8uDrEbgZtRycbCdGQybe67aPL
         3DCoySf31J0gtYB+DQ3mPe43e3TAK+SbNqizYgFHtzy7TBoGCnaFwQ1g6erxUZqndg
         xt13ivhiAB7ozmZaruYAZ0nAdhsdCthIJbREd2t4tiFlgfAk3BDGP/EoPUKIAS0gYQ
         piMmnyjKKGduBu6tXLQIaNaqP+aXkngp6iUqGb7n4Ox/WVbRSY3a+cltISZXbdKdIj
         /6yCrTM5c/5JQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 18D6AA006D;
        Wed, 15 Feb 2023 00:55:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6BD7FA01FF;
        Wed, 15 Feb 2023 00:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTrcSLZlMLpg2Sqv67UP4uzc7rVZc54Lvk33Mbi21kUW0aYL9Tawy/Tf1xS9jjSTPxtDPnzA9vloqnT6VHlkqCLD+13OQu3njVI7rROgE6M/2IEzXnn3X5hK8NQZ0XCZysbET3WbVVAptwtKh3dl/0tC9lUBufDJK0tpCVhnTHfQRa5jm13I3Uf8zApk4TBb/s1jq8JQRBj6uS8aJUZKeKTMUn4vUqlf15TGD5B4eKDTouf0BKP83eUAzjX7ErO4+ByOgsv3AhVsFB2M+WxhS36IC4xW5ICsoVaId2i/Tmiy8zN3VnvwOErlbli0yeMOsFqcnHV7jWbxf4Wztne53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38wFCJCrK8SUgxERv5NqHgGiQRwn0PD7FQ5ua9KaVgw=;
 b=F3Vim4O/B2FIOEYVHVmFz9irwa2YD/M+OxiLORQrpkpNQ2sYkpKXOOESiBvaPGCMa4k2dCjgP9ZgXcWrs4Bsypn74QcCEacYFEJmKAwrmodD8VaC9dA9uXAJbwTs5J8QIFUqg7EFiHjHBEi1thqZKb+hi5xoh2q+QPwPHMs6ngyW0vVA7ySSduRBametNTe/4Qmf7jREr+/WdS1JQW15VmqdikQxRCqHG8bQWlHaX6tNNfPhSyvOvm5RqPCz5IVZRQPFZL/nR1xrJLNqfBch8Qe2I+vwhT0Xhr7xxkWXJCv7zABiEkSHANEAFrE1B0PscgwDoZcu0zgzJGDXzvzm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38wFCJCrK8SUgxERv5NqHgGiQRwn0PD7FQ5ua9KaVgw=;
 b=Yp3yPYi03kyWvG1ONYGJwXMqKqpNI0NHuVkMRQBMdt3hVGo/lFVE6HKLFYheiEHscO1K1R3wvnOTi+UzHjfFYr7P0gg8sb5eoJKIHdW6Sd9M7yu/Utgz+OHcjrrvNSnQotOBWwXEldOqovZMgmyXRuDtw3ME+eNrfQwgBDLQkCk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 00:55:26 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Wed, 15 Feb 2023
 00:55:26 +0000
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
Subject: Re: [PATCH v4 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v4 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZP+HIlHhLWWpmVku4JsgKZV5bz67PMJYA
Date:   Wed, 15 Feb 2023 00:55:25 +0000
Message-ID: <20230215005520.7pw7xmlyi7oqgl4p@synopsys.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
 <1676316676-28377-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1676316676-28377-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6566:EE_
x-ms-office365-filtering-correlation-id: 5be494c3-b31b-4940-3e9e-08db0eef5337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7om2kwJQIPAZp2yuTYsCIHKJTjheP6PZtCeVjQfVKXtsPFZyurCwguPBJ4+C6umYw9XFV0+5w4WreoyXfIrUS63527aXXH1GNFJs7wYeFI7832O2m+k8n9juZVx/1pK1qrDd8NujG4TtsnT18K6R+g5piCEiSv1omueLjaNcSlibPFlaUOaD6S8nqre674NVLq7o85V1mUFxZ2msuH8Zl3acd2UbPc4T6lyAlMunUK85wH606iPUyaYLlRDDJ42990n770N3ZMSTBHDLMVxAheILdZx2d/6hjyjPTi8R6rDipSqnbfz9Obh+nBSy5lQGdbvnM7IWw6Z6VN8XhHjDqrbWF+rAVcaeb5l/S2l3UPYXn58JwKMYMUb73wB5k8JK5NUx/33z6q72IzcY24q4//n8JZ/i88BsW7XcQQ/oOItkMJa//F/Rsnkl80RnDqJJgLa5chve13qx2q9jw1rKbVFG3UAOP5k/YO8LX3rxM9fPfyOq/YPYkozfvR3+hHcAPKnDd8MjFGH4E/U2zE5Fcm/LmvxERpra1E+ogeglP2DlzCYHAompuWX3BUAcvv+GbL4FmspogBsTPd2xzKhIJmFPtNAD8gYmyV2gk+Ij5yjMlZGS4uii9decr/wR4r4RFqbk9yYygslKezaEPbjirVmqHQY/3VKAKjvGnBESW2ga/MRxWZoG10TlXkkLFTXHuumzXd8vCsazq86FBhHvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(316002)(66446008)(76116006)(6916009)(8676002)(66946007)(66556008)(66476007)(64756008)(4326008)(41300700001)(6506007)(54906003)(8936002)(5660300002)(1076003)(2906002)(6486002)(71200400001)(478600001)(122000001)(186003)(36756003)(6512007)(2616005)(26005)(83380400001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkxFTG1CZTJCMG5RemZtOXprc3pZMG4xYS96NUUrNm90SWRFa0R2dGI5T3Mw?=
 =?utf-8?B?ZHJZK01ZbUVyMDdmS2d3RGtUd0JaMGdGWkRKMG1uc05SUlNSRlB1WkdtMGpB?=
 =?utf-8?B?QVVFQ1lHU29yLzIwS3hTNWwyeDZGSzlxTDEwblM2ZFJpNXdQY3MwdWN2UExN?=
 =?utf-8?B?dGVjVFZ6SUxQYjlxcGlFcWN2bjM1REdmcWxoaXZkdHJ4STIvekFYRWl6V1Ju?=
 =?utf-8?B?MVl2ejRJNjBQTnVzOFJDNmhka3lTM2ZhYW1mRzloNXV1UGw4bFUrYlFYdzFN?=
 =?utf-8?B?c2Q1c1hRdjdMS2VGYm9JSjRIcTdKNzVPZHgyRlY0T09mS0p2M3VwQlc2T1do?=
 =?utf-8?B?N01UeUpMaEJiUkpzSXpSV2lLWjhzaXpGcTBSYUN1OTIzUzRMQjdpUlBHemtL?=
 =?utf-8?B?VjRoQ3lob0IwTzkzWlB6enFuZlpyUVNLWjVWR0RDNis0ek1Da2VjVTJSQ09F?=
 =?utf-8?B?cXgxbm5HOHBvZ3lJcHgyMWo2QVhNOEtGNjdwODE5cmxIcHpobng2dy9NQVA4?=
 =?utf-8?B?VStQKzQxN0U4enN2K2FFbUcyUmNmdDZsVXlVb2ZvZGI2cVpDSURSSlcxL2l4?=
 =?utf-8?B?cVJJcmd5QXAzdnRXejJDajZKbXZyb2poRXJseFRTSS83bjRaVGxKK3BxdHBR?=
 =?utf-8?B?cEcvb3ZzTDJUbW12dFJyYW4rR3Y3SDFhMkFkLzRBUjNudnAyOHlCVEF6QTVL?=
 =?utf-8?B?YW9mZ0szdTBZTFA4eU56emkvOHhMbzVDRFdLdTZueENiMEJnbG5aWFFqRy80?=
 =?utf-8?B?SGhnRTFzSmk4WWlJOWgyMVEwNXFzSHptR2FiY1c3cWR1RFlCZjJlOXlFOTMr?=
 =?utf-8?B?ODk0TmlMdU9samRkRUgzNDFZdFFRV2RQWVQ1NVFjUlJsUmJPV2ZpaCtreDBR?=
 =?utf-8?B?Q0x5VHVsS3pEUnVuM1RaRWllaThkRHhtUy9OZytSc2JKZFc3UW5kcWJnZi9D?=
 =?utf-8?B?dWhCZm00cVY5dXdoMmJXUlNOeDU1Qlp1czdFR3VIdkRML2czSjlWeDBBNER4?=
 =?utf-8?B?YWJmVDR1VWFueHBCQkpKZkZpcC9HZ3BQTWZRQ0JKeTE0VUpHYVVHT2Nvam9k?=
 =?utf-8?B?Zi9kTW1kNG5FUUR2bzZjTG9sMVVYWW9ZTmdXODRGcVpKMFo2M3E0WU9wM0Qw?=
 =?utf-8?B?WjJBV25TcWVQRVhSNmJjTjZSY0xuUllpdE5DNXNhZFJFYnZSOUxXR1p6L3hv?=
 =?utf-8?B?eU1ON2txMlhOVjRsK2RUZGZQQXNkM2J4T2VTSklNdlhkVHJjSWZNOExWYjZP?=
 =?utf-8?B?ZUtkeU5DNDgzYkpPYU5DRzNHQ0tERlM3d2VXd0V0K0t0YkoxQVBJOVBTazhI?=
 =?utf-8?B?N1hDUXRRQURGZlQ1alVFRTg2WHdaOFN3clhCdlQzb1Zodjh1Sld6cExIQzcw?=
 =?utf-8?B?bU56UWp4eUhQTDFQQjlqeDlWV1JLSjh2bzNZRmNYL0hpZTVKU0FyaUFuODNx?=
 =?utf-8?B?OXNMQUpkbzllY3RhQzBIUlEvZVhWc0J4dmRRdmVWazg4Mk9EMUhMcHB5cFFU?=
 =?utf-8?B?UGNLUTc2RTdmTHE0UGdsb2tVZXQrWGRRWnJaUFVGRllsNWk5NW1qeEIyTmhx?=
 =?utf-8?B?YzBQdkNNK3lSQWZTR29WYVhqR2w4eTIrei9kLzAyaFlwSTdBVmxNNnRURDMv?=
 =?utf-8?B?L040MFRHbFlJclZrOUhUR3B0OWFmNEtZdjZ0d0g1WEJ0UVBKMlM3d3BZWU5n?=
 =?utf-8?B?eWI5WDlyZDErQVZtWElXenZNSVltUWFVQXhMK2tRZEFRUXlCVHBuVm1PMFU0?=
 =?utf-8?B?Tk9ya2VtWkZjdW5tcnZVWDZ4K2pCTUF6UTkyVHJ4RmZUK2t5SU9sVXhRcWtV?=
 =?utf-8?B?Y0pvZld3R3Y5VWhadmVlWG5CZXMzcms3Y0RRb0xTUW5iRVhGTVFLeGRTWmtn?=
 =?utf-8?B?SFg0ZlVyR2h1aGk1dG5IaE02VU9QbjFZQnZiQ1UyYllzejgrUWlodHZ6MkRP?=
 =?utf-8?B?M0tPVmVPRUxtMDNNeVFOelYyMXNLUHdVUkJlbVUxQ3R6UlBZM2xuL3NKRzA0?=
 =?utf-8?B?Y2dTM3VmS2VxNVlKNGlUWnpjQmdzYzFZWE1GSkR2bzJ6ZFJrTWViWEJzb3hY?=
 =?utf-8?B?Rk9zM2xEWm5BRHI0RDJhWVhFVjhSZzBSd3o4NE1ob09kTlZvSnhkZWNZankx?=
 =?utf-8?B?OFFsZVdhZW1EOFMwdmVTL085TFA0azVWcXh3eUxFbm1sdG1jV2NYd1puTWFt?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20327057E67776438854BED26B84C367@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BVvB8adZ4v6bQMhKBHdGA5awD0mbCPXnGly96geFfZSTK4aKnq1WpRvwLjS3r1kG00rjxfk8ho68v83Tzn4rfKeVRqRLfmS42i3Mfc5RKtB1ZU2I8vTr8+X0k4MTWXNFccO1aOboxW0qc9Pn4OP/iH5W5GtdsRgFl/wtxbAKNO9ROnwd05FLgFyGKE39azUOTzAygUUkqX7lfyTc6eeFiY06gImJI0C9+QbDQNABNcFWIo0g/OuVkdvd3x4AwyKc1Ix5HAZsSYeGqYpbHUJTavodY/kqNc012fRxpLkAlPGfUWO+HjOhsB97cJNGiFYXjiy4xMdsLU8RmKNa2/o10mv/gGFN8YE6Z6cz7eYmZ7hFNJP129L8cdbpPPFe2JibBNMwtJVL5JElvC5iVxELN9vhkRQYyuoA30R5uDSN5+xOSfygzFMoNSxzcCFGzGdkOFPYcbLr4MoD1Y6v1WO1BRX5Zmr3CusiG9FjezCB3JydFIs5qlw0bEAtnCml1vFP6T12Ojvu+2jMSSZD0kD6yEyGWQEp+a/7pOMnOFj/JEUqE+/byfUbHSqDsAo3oVATfBvLVOXSElalVWZWk7maNFMxQCrRpTdcZ18t/W67TPwyHMvChm/LYjOhP2VYmy0GWjMzvEc+MjhOryvQY9nZOfGa1+Ji1fikMoRak9t+W2urA8Fo1Wi48WM3IfXD3nzUkBgdG3hSz45iBY1p0bi4ASUhHmPKt4gKXfPuJMvlud47elSRMtiXpam1kzQhv3Ffp0jzYdI9t4jyqoRiiE2Kj+fjOb7jMTQvJDAsEZm6tW4pdgwiL+t6SY5Gr204H/9qXHIHcOmUD0FjKBvv8ZAFCeyvR5vXeeMywwKBcwLiE8CxJAcChWMr2aruNuV2IyPlcZjxw4lMEyp7aGEvBS4oXSQxZemooxn0AOkecdqJFls=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be494c3-b31b-4940-3e9e-08db0eef5337
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 00:55:25.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ah5s/TtALrOzJlK5WH5I3eeQ0LJWylpMm6XpduUdfQQmJE5KhcgKS3OgEuEnr53xO7FE3s+Gv11ArnphhHMWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
X-Proofpoint-ORIG-GUID: ac2B5riQFawMo2kEOH5Qb6qxNb-SaLAh
X-Proofpoint-GUID: ac2B5riQFawMo2kEOH5Qb6qxNb-SaLAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=683 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEEgZnVuY3Rp
b24gd2hpY2ggaXMgaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSBoYXMgdG8gc2VuZCBhDQo+IGZ1
bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHRvIHRoZSBob3N0IGluIGNhc2UgaXQgbmVlZHMgdG8N
Cj4gZXhpdCBmcm9tIHRoaXMgc3RhdGUgYW5kIHJlc3VtZSBkYXRhIHRyYW5zZmVyLiBBZGQgc3Vw
cG9ydCB0bw0KPiBoYW5kbGUgc3VjaCByZXF1ZXN0cyBieSBleHBvc2luZyBhIG5ldyBnYWRnZXQg
b3AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9A
cXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Nv
cmUuYyAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvdXNiL2Nv
bXBvc2l0ZS5oICB8ICA2ICsrKysrKw0KPiAgaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmggICAg
IHwgIDQgKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IGluZGV4IGEzN2E4ZjQuLjUxZDZlZTkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvY29tcG9zaXRlLmMNCj4gQEAgLTQ5Miw2ICs0OTIsMzAgQEAgaW50IHVzYl9pbnRlcmZh
Y2VfaWQoc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjb25maWcsDQo+ICB9DQo+ICBFWFBPUlRf
U1lNQk9MX0dQTCh1c2JfaW50ZXJmYWNlX2lkKTsNCj4gIA0KPiAraW50IHVzYl9mdW5jX3dha2V1
cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKQ0KPiArew0KPiArCWludCByZXQsIGlkOw0KPiAr
DQo+ICsJaWYgKCFmdW5jLT5mdW5jX3dha2V1cF9hcm1lZCkgew0KPiArCQlFUlJPUihmdW5jLT5j
b25maWctPmNkZXYsICJub3QgYXJtZWQgZm9yIGZ1bmMgcmVtb3RlIHdha2V1cFxuIik7DQo+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCWZvciAoaWQgPSAwOyBpZCA8IE1BWF9D
T05GSUdfSU5URVJGQUNFUzsgaWQrKykNCj4gKwkJaWYgKGZ1bmMtPmNvbmZpZy0+aW50ZXJmYWNl
W2lkXSA9PSBmdW5jKQ0KPiArCQkJYnJlYWs7DQo+ICsNCj4gKwlpZiAoaWQgPT0gTUFYX0NPTkZJ
R19JTlRFUkZBQ0VTKSB7DQo+ICsJCUVSUk9SKGZ1bmMtPmNvbmZpZy0+Y2RldiwgIkludmFsaWQg
ZnVuY3Rpb24gaWQ6JWRcbiIsIGlkKTsNCg0KVGhlIHByaW50IG9mIGlkIGhlcmUgaXMgYWx3YXlz
IE1BWF9DT05GSUdfSU5URVJGQUNFUyByaWdodD8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSB1c2JfZ2FkZ2V0X2Z1bmNfd2Fr
ZXVwKGZ1bmMtPmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0LCBpZCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwodXNiX2Z1bmNfd2FrZXVwKTsNCj4gKw==
