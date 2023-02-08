Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB168E5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBHCMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBHCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:12:14 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57438976F;
        Tue,  7 Feb 2023 18:11:57 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3181WGrL009093;
        Tue, 7 Feb 2023 18:11:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mWGa2a0RllDU9wMqET0Z0jIRtwjfFv+EMLTi9e7R7uY=;
 b=swV4cFydmxXatso/dXJ2sW+ZeGq7Oq6Kc0RLt7Xx/sET7zYCx2G3Qgit9UcNQR641qM8
 YHz1/pAQI0LdQjObSzd1XT5H7s9+aTAbA2n8IsmVicddGkAgKaJC/cTVhcVHsJ2EpO2/
 yWS1SkksAMfnz2ZlfecZxIbk6Ch7K75RJl6GzSpC40eO8hgVTk/RAc5zf3RxS7yQFUn+
 FcToS+zdSBfQ6TCXMNWC9RIQ7XNajwFN0f57R7MX8oVH4z7ayTNXovLmhv1S5qmmHAoY
 Or5bKEnClkEdkvCGAc5YwTIk79YTf81YxyF6JwzA6ZPuTJmAEx0bObC7rS87FKlm0M51 iQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nhq8uq148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 18:11:50 -0800
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B3A39C008B;
        Wed,  8 Feb 2023 02:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675822304; bh=mWGa2a0RllDU9wMqET0Z0jIRtwjfFv+EMLTi9e7R7uY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ImHOFDqabHzFtIAeoFrqsypG0jCaN5GHbgnZ3N7kz42sZPa8BDr4OPROFSB9Re7+l
         ryt4QNTAfLclxGT7kI5d1oHVD5c4/lXv+w/V+Zq8Uc4bvbV9jTMFzj9G4U2q7w5S/o
         fkk+Xf9Zh4JWe7dpjHswDdJJ+Mns7kvAC0NHafBrtaEse6yPDazl6wXt81/QL3BsUg
         5TLhQR3cmgErMreRK4Gx3BDLoWtRWvqJ/VFP1O2ZabPl/qE68ILUyXdQx1N2cvJ3nu
         UzqG8fxQMHUNqP7qjr5Im0D5DxM8HImu6OhcrX+X+9yaUTkuaEzOhOuCL5+/3oT44X
         m7nahNENOa/kw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D52EEA0079;
        Wed,  8 Feb 2023 02:11:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A28BE801E7;
        Wed,  8 Feb 2023 02:11:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="GIb3XP4G";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSNH4PPktUu2oUFX898softoSzuN8MaTyt46RPupcdkS0CyJAV2J1dJZk4dobNOxTdNOVHKqNNosiWmYEooLpmFkK51iVAN/vYugwIKRYRfk7pZRRLy2DVoCMrjSn5YQtTCo4GvTQ7avIalcijgR6Slv66T3NZbR1pCHR9owngqDgo0QIiicy3QQh46iorXRqq54XYt+xeJHYvVe+QB8Tqe/KXQ1wYk2H25zC3M7oA1+ZgsaWMwMStgP/3gYf3PlAzGRo0oH7RtLPZXhTK+eJo3u/RTenD9BX+V+JaWJeLdDsUu3dPLLgqFzKNcHCxRO/KlsDN25BOT9DqBW3ONLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWGa2a0RllDU9wMqET0Z0jIRtwjfFv+EMLTi9e7R7uY=;
 b=aTvqUa82oK3/PZ+3P1BsDZHzNttWA2xERkvAtZ1JyaMt/Ha9U/fYwJp6t/Bdy3Nf6fAmhV1f9DLcYnW9qwaRdqq0Q74J/IEnG7GNTIL34pYmRtjO7kWq/1cljgKTA454sf8xeP8PqCnlcfpV1HxJISL4+k+91oHGityIKOLcqoEBDWWVPf/8sHgM7WsdGbs1xZjYD1S9PH38KuNZVIvZzHMMwIKnmK3J0QthuYzaw6k61s5Lnr1ViH3aA2F+Mwk1ln1DLY3JnOV003G0zH159yrlQ9djerLYoGycgPnUbGZ2IFlt0QZENC8ZUVL5WS52D6iEy1lYYEv+t7pU/Y3DZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGa2a0RllDU9wMqET0Z0jIRtwjfFv+EMLTi9e7R7uY=;
 b=GIb3XP4GGGKk6Q5p09TjBbzrbd0grNeU8koYEFDhsExbMyEXyvl+b0EVsJr1W/prWj9TzIXFJUcjbbA3Y3BUxrVf8dcKa1TutCHrf6ZMoZhoH6VRhPybY4UQhaO8SjQw9eSW48K3c1esuW0u8Ur5DlHq6Nlfhh7lE9tvorNfbQY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 02:11:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 02:11:38 +0000
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
Thread-Index: AQHZOl8gO3KZIGBpqkaJFw/1xTLpFK7CpxCAgAFu9ACAAClzgIAAC6eAgAAFcIA=
Date:   Wed, 8 Feb 2023 02:11:38 +0000
Message-ID: <20230208021127.syauhdtpbyyncixr@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
 <20230208011017.47o7m3xt63lbih3m@synopsys.com>
 <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
In-Reply-To: <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH0PR12MB5075:EE_
x-ms-office365-filtering-correlation-id: 5b7d0766-5572-48af-0ac4-08db0979cf90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9J9V5DkJMv1EVLFl4jGB8J5CvSKOw/GQmQuih80rWNnQvP4VPvlRcVCT3JEQjRDYc5jn4RmzM1tazgm15i7XJZM68AyMJ3m6khYms4cUI1ewYg5Oj/OrqZnuB6rhRoh9sRaejF25ttoa9+eQStyx4qDK85FY+kz7D/fZVyf9qevALC7r+9uKWB/9DQYQlRXqAW2QKbSVWuEbFrdOqQhhq/JFQKNEZpvAAYXKPhagQHQyNVjetoEC7cTvKYMfMNXRDzRyluQZaBTjrAOKZoL+Qltun9Lcc8AA8dTHbgRazgQYy0jzYLgu/uAb9buAMIBfgU84KzuBGbqajlGOYkn0PGct6ScSt4sY3TYNP5WubjozPMxHMAtL4TROzClAGWGz5slKzd4DbVWhAq/sJwMvbZD0I2Ly3oc+MPKq1D7MX3+2lxJOPev6K5ViPtoT4gQHipITAjQCbpgSPlQpvAJfeDjtstxQUkM+cJoIdnt4cumr6PdQ5BeghYodKWka17S2Md4dpaYEm4TLV8Y4D9C+I9Jgu1wqFYHAEXYyM7xaHKQNradFeuzbjl8TvQSpbX+1Lb8mz/ARSrWDHeJcyVP2BXTFtWjZ4+fhCRPXCvx85JYPQSPuQ4aspyjr/ySTcsWQCzdJtt4cpAy8EhHLLvavERLjT3zIbEbC/OT98Gj94o5nyrBinsne39il2HryXlcS1UOmJHc9SfExCKLAA5HsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199018)(1076003)(36756003)(2616005)(186003)(6486002)(478600001)(71200400001)(86362001)(2906002)(122000001)(83380400001)(38100700002)(66476007)(53546011)(5660300002)(54906003)(316002)(6916009)(66556008)(64756008)(6512007)(6506007)(26005)(41300700001)(66446008)(3716004)(38070700005)(8676002)(4326008)(76116006)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjFvREVxT3ZsUWhpYUJRSnJtT2pIN2E3S096SktTMThRM1hJRFNqa0xuakpj?=
 =?utf-8?B?ZlQ2UmZ0TU5jTWs4WmhGSkpBZm1uampzMFdMRkFVTmszUDY2VlQrc1lZcC9S?=
 =?utf-8?B?UmxzaVAwL2dFQnVVaEdHbGNXTW83TGRRM1EwYXQ0T3Q4RlBsOC9uNTRHUVlW?=
 =?utf-8?B?MHh2a0V2b25Hb2poeFp3Mzlmc0x3TGZTK28rQ2tSNWtsMFZWeFVzZkdGYVgy?=
 =?utf-8?B?eHRwVjZQc2M4bm5KaGZiMzVWeHpCZWVqWTNuS0lETnEvanNPR05HLzNudnR5?=
 =?utf-8?B?Y1d5dUhHZng2STlJdDhtU2hiWUZkVnl5WGlGYmVSQjRPTW5hQUd2YTVyLy9O?=
 =?utf-8?B?V3F0dXh3aEtjU0FYVWo2b00yNVo2T3BJVXd2MHVWeGhIQ0RRcm5qUHJlSERI?=
 =?utf-8?B?NUVGRWNabGhIaHZ6dGJFQm01RjJZUDRIajJENTJMMVZIb1BvMUc2SlZKZWpr?=
 =?utf-8?B?TGxsRytKSE5WcWtCRmNmNUFraGEzTjV5ZHlOTzEzRWgrTHAxZ21TNC9tOFla?=
 =?utf-8?B?WWczelAyODhJWkQ2ME1wRGF6Y3crRXdzWUF3NHpqSWtLQjZLRnllYm5lYzBu?=
 =?utf-8?B?THkvK0NSYmwwejdDOTZGNlQ1WFZBV0l4SHV1Q1gzK0doMCtwM1RzQnViem1i?=
 =?utf-8?B?elBtUDlxdmFUREk1VHBFUVA2VnZVdTRnY1ZyNE5tU1A1NTlxSHhFSERJTDNR?=
 =?utf-8?B?bWhHSVBDRWE0V3VLVlREZTNYS0l6UDBDa05vZU03TTBtU2xOUjZ1dkRFSjJW?=
 =?utf-8?B?c1c2Lzl2UFptVGN0TWVHTU1kZDB4NExPR0RzZndONW9YbjFNQjI5RUhwVm9v?=
 =?utf-8?B?WlhwZHhNU3htSzFuSklrU0I3Tm91T1V6QVNjSDU3b08zc29ISnJrNFhjeGxE?=
 =?utf-8?B?cHBXWHBZVS90ZjBpMUtRd3NuY1NWOCtla0U2am95YVNCVklVSHlVSWw5VFgz?=
 =?utf-8?B?ejU5VENsc2hETGlVOHB0Yys5N0k2dkFId0VWd2VEbExuN2F4Wk9XbGFPZitt?=
 =?utf-8?B?ZDk3YjA0dlpDQVBXQTNlUjUrdnJmdjhDbzU2dVFkc2d0VXR2bDAvNFZzOFpu?=
 =?utf-8?B?aHVPWmZtQW45UUszaWR1Y2JOQ25XUE9OSUYycnBta09PZ3pmdWpXZEdCLzlw?=
 =?utf-8?B?S1ZUUkRnQVArblJ4RXRBRVFJVG01K2pCbStYUEVRbS94dmhzVk1Na3lGVEd1?=
 =?utf-8?B?MVlPR3JHcVhLVVlHcitSTy9GWXFyUDFva2ZUYWpiYnhEVStOaXRKaHlrMnhz?=
 =?utf-8?B?RnB6aFJIMENwOTI4aThWQXk2V2pmbFNJR0lZR29ESFNIVFNqbER6SENiMDFD?=
 =?utf-8?B?aUVxZ2FMNXhrdVprQ0ZITHk3Mjk1a2pRTVJaUFZlQ0lhQTZ0NnM3VVMxL0Q3?=
 =?utf-8?B?dDY0WWwwOEtGbU9zUU91MGp4WG93cFVlRkd3SDNLZGxqRFNZeSs5RmFUQXFi?=
 =?utf-8?B?M0VxRGNvODM0NEcwTE5xbjl0em8yb2JKcTVMSEs5VWFvNWhhb0tIeUxaKzVl?=
 =?utf-8?B?L0R3ckpWSVRwTzZ0d1dPc1ozY1BmeW5GZk0ybUlBdmY1R3N1eG9lUUI4clEx?=
 =?utf-8?B?clhaL3ppVjBTR0RMM0JqejVrK2J2dGJYVCsreWZucEs1NytMbzBSWGhJampV?=
 =?utf-8?B?M2JHcnlORjRJenB6eVhUd3dMNXdUeHNvcytzZHdDQjVwUjVyZ0hNM3o1enVS?=
 =?utf-8?B?RmRibUNjb3l2Q2N2dTkrSExUUEE4WTFLOVZGNXc0d3NVS3ZJWkkwa0hYWTgz?=
 =?utf-8?B?UlNpUTdOOWJ2VjlxUk0xKzFFQ045VFc4dVh0U3dHNmllcFNET3dFNzgxWmZD?=
 =?utf-8?B?UzdsY3pnTXNsNk5RcXl3dUhlKzZUMERaamNsMHh0cVhWRi8xc2Z2WngyMDBj?=
 =?utf-8?B?Ny8zOUlha043WjFSVlhRY3BHY045ZmJVeXJUV2ZJQlVsZ0RTdVNkNEk5enhQ?=
 =?utf-8?B?Y1A3S2hna2FkOFJScWVPM3JnN0xVWUxXT3dGS0dYdWxvNUFqS3RvRmZIblJD?=
 =?utf-8?B?eU5qaWRTdnpUblp6VHh4NTE5VTVoMjRyc203Q1Q0N3ZNWSsyeE9rOG9jOXMx?=
 =?utf-8?B?UzBqd3RuRzhOZzNXVnBRWEJFQ1RLbVBGUnBoMXh5b3hYa2lpMWlVUENLaWVO?=
 =?utf-8?B?RWRkQnp4Q3ZBZUM2MVJaM2VYUHQ5bmFpZUNlaGVJc2Mrc21jTHBraEloODls?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AEFC2741383AF46AD325E801E074C60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eziaYsOEZ2Xe8AlGJ9p5Ns5wnlvXthx+mM9qmwPAq5fOyRQJm7n3MR58izs/JZOcqdDw6pdOAsy1hI6CIRinadAa2qvt/8CzdVXBMyMLKlloL7+nOdS0SLABQGvZI1CRQkFXSt576CJ5LB4b7NNLiYyegaVZ4+s3nbgPJajiHerpanv66Wg43QXUuQ0Ye/aHde203xs1T9aj1plKfJez1TSZmRc6ve34pM1BetBTy+qZWaXG7/zpUV33m01KM681SR+eM3vweVmkubjzuuXLYr+f/BRrFEShvbTKR9tl9Pus98rs0zDMdgJaABTNIVMghBDhNCcd24ON9Hc5F4JfLBf3rmPxityiqIO8AUtEfxmFhiD27ytxGy3/g6x1KYeQpcx090/Nyi0ncZPvwqNf4mnZbth+uzGyUCaexZdyLJln0NhuszErlBy5l54RlmMmPc1vYXtRWAwpW/EmqcCizafKwTalR1d/6BN7e5fzUuN+KOADMSaz7xNBeKDJEr1vVusf73FNmZeMYYTWIv43k1lp9n4qZwfwVsYXed/2qA6b3rkikSjEpavDniKzFjvr0Tf3K4h7He7q695I+duJSAfEOzmWLBG3F7tk/ErtP+KZkNVAnG09uJn6EXMXtn6Qr0UkH/K56e2yKBkl+daep2FsHszgi4s/8Ush/uPI/bnvck6a2O+7nOnnIF7WlN6Q+A4y7z7AfJWPnoGDyfeX2/AtvvD1pnMtX9qNKWbJe5tjdRuI7Iva2Zq8xIEWUjvRFdalTLUnzEDbz/m56cRFN8hgjPJ+boaDKQrThb1AukUVmo5UDkGiz345QPXc+xT+OU8xCCQvWV5Kl7IQMWAvW8oC+U1g7VAcqqEOD1UpR0/ibPPbTAfJAm+ZOp6aFYMST28A7AvoodIoIlpVsXUrY8U205VNvua6AIH5y3EqpF4=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7d0766-5572-48af-0ac4-08db0979cf90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 02:11:38.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dxhMKXlRxAaTXp/5dY2CmNZ0OshlS3KLanC0tQoXQxkTLiO2KA5WOTmE7AL6P4JcLyc1R25XIlk5kofv7frtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
X-Proofpoint-GUID: i5GuxgLg3093byrTsmCXi_UXtLOCqhRu
X-Proofpoint-ORIG-GUID: i5GuxgLg3093byrTsmCXi_UXtLOCqhRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMDcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAy
LzcvMjAyMyA1OjEwIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVHVlLCBGZWIgMDcs
IDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiA+IE9uIDIvNi8yMDIzIDQ6NDggUE0sIFRo
aW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dh
a2V1cChzdHJ1Y3QgZHdjMyAqZHdjLCBib29sIGFzeW5jKQ0KPiA+ID4gPiA+ICAgIHsNCj4gPiA+
ID4gPiAgICAJaW50CQkJcmV0cmllczsNCj4gPiA+ID4gPiBAQCAtMjI5Niw5ICsyMzA5LDE0IEBA
IHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+
ID4gPiAgICAJbGlua19zdGF0ZSA9IERXQzNfRFNUU19VU0JMTktTVChyZWcpOw0KPiA+ID4gPiA+
ICAgIAlzd2l0Y2ggKGxpbmtfc3RhdGUpIHsNCj4gPiA+ID4gPiArCWNhc2UgRFdDM19MSU5LX1NU
QVRFX1UzOgkvKiBpbiBIUywgbWVhbnMgU1VTUEVORCAqLw0KPiA+ID4gPiANCj4gPiA+ID4gSXQn
cyBhbHNvIHBvc3NpYmxlIHRvIGRvIHJlbW90ZSB3YWtldXAgaW4gTDEgZm9yIGhpZ2hzcGVlZC4N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoZSByd19jb25maWd1cmVkIGZsYWcgaGVyZSBpcyBp
biBjb250ZXh0IG9mIHRyaWdnZXJpbmcgcmVtb3RlIHdha2V1cCBmcm9tDQo+ID4gPiBidXMgc3Vz
cGVuZCBvbmx5Lg0KPiA+ID4gDQo+ID4gPiBUaGUgcmVtb3RlIHdha2V1cCBzZXR0aW5nIGZvciBs
MSBpbiBIaWdoU3BlZWQgaXMgY29udHJvbGxlZCB0aHJvdWdoIExQTQ0KPiA+ID4gdG9rZW4gYW5k
IG92ZXJyaWRlcy9pZ25vcmVzIHRoZSBjb25maWcgZGVzYyBibUF0dHJpYnV0ZXMgd2FrZXVwIGJp
dC4NCj4gPiA+IA0KPiA+ID4gU2VjdGlvbiA0LjEgb2YgVVNCMl9MaW5rUG93ZXJNYW5nZW1lbnRf
RUNOW2ZpbmFsXSBzcGVjICJUaGUgaG9zdCBzeXN0ZW0gc2V0cyB0aGUgUmVtb3RlIFdha2UgRmxh
ZyBwYXJhbWV0ZXIgaW4gdGhpcyByZXF1ZXN0IHRvDQo+ID4gPiBlbmFibGUgb3IgZGlzYWJsZSB0
aGUgYWRkcmVzc2VkIGRldmljZQ0KPiA+ID4gZm9yIHJlbW90ZSB3YWtlIGZyb20gTDEuIFRoZSB2
YWx1ZSBvZiB0aGlzIGZsYWcgd2lsbCB0ZW1wb3JhcmlseSAod2hpbGUgaW4NCj4gPiA+IEwxKSBv
dmVycmlkZSB0aGUgY3VycmVudCBzZXR0aW5nIG9mIHRoZQ0KPiA+ID4gUmVtb3RlIFdha2UgZmVh
dHVyZSBzZXR0YWJsZSBieSB0aGUgc3RhbmRhcmQgU2V0L0NsZWFyRmVhdHVyZSgpIGNvbW1hbmRz
DQo+ID4gPiBkZWZpbmVkIGluIFVuaXZlcnNhbCBTZXJpYWwgQnVzIFNwZWNpZmljYXRpb24sIHJl
dmlzaW9uIDIuMCwgQ2hhcHRlciA5LiINCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93
IGlmIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuDQo+ID4gPiANCj4gPiANCj4gPiBJdCBvdmVycmlk
ZXMgdGhlIHNldHRpbmcgb2YgdGhlIFNldEZlYXR1cmUgcmVxdWVzdCwgbm90IHRoZSBkZXZpY2UN
Cj4gPiBjb25maWd1cmF0aW9uLg0KPiA+IA0KPiA+IFRoZSByd19jb25maWd1cmVkIHJlZmxlY3Rz
IHRoZSB1c2VyIGNvbmZpZ3VyYXRpb24uIFdoZXRoZXIgdGhlIGhvc3QNCj4gPiB0cmllcyB0byBl
bmFibGUgdGhlIHJlbW90ZSB3YWtldXAgdGhyb3VnaCBTZXRGZWF0dXJlIHJlcXVlc3Qgb3IgTFBN
DQo+ID4gdG9rZW4sIHRoZSBkZXZpY2Ugc2hvdWxkIG9wZXJhdGUgd2l0aGluIHRoZSB1c2VyIGNv
bmZpZ3VyYXRpb24NCj4gPiBsaW1pdGF0aW9uLg0KPiA+IA0KPiA+IElmIHRoZSBjb25maWd1cmF0
aW9uIGluZGljYXRlcyB0aGF0IGl0IGRvZXNuJ3Qgc3VwcG9ydCByZW1vdGUgd2FrZXVwLCB3ZQ0K
PiA+IHNob3VsZCBwcmV2ZW50IHVuZXhwZWN0ZWQgYmVoYXZpb3IgZnJvbSB0aGUgZGV2aWNlLiBG
b3Igc2ltcGxpY2l0eSwgd2UNCj4gPiBjYW4ganVzdCByZXR1cm4gZmFpbHVyZSB0byB3YWtldXAg
Zm9yIGFsbCBzdGF0ZXMuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRoaW5oDQo+IA0KPiBMMSBl
bnRyeS9leGl0IGlzIEhXIGNvbnRyb2xsZWQgYW5kIHRoZSByZW1vdGUgd2FrZXVwIGlzIGNvbmRp
dGlvbmFsLihTZWN0aW9uDQo+IDcuMS9UYWJsZTcuMiBvZiBkd2MzIGRhdGEgYm9vaykuIEV2ZW4g
dGhvdWdoIHdlIGJsb2NrIGl0IGZyb20NCj4gU1cgdGhlIGwxIGV4aXQgd2lsbCBzdGlsbCBoYXBw
ZW4gZnJvbSBIVyBwb2ludCBvZiB2aWV3Lg0KPiANCj4gVG8gY29ycmVsYXRlIHRoZSB1c2VyIGNv
bmZpZ3VyYXRpb24gd2l0aCBMUE0gdG9rZW4sIEkgZXhwZXJpbWVudGVkIGJ5DQo+IGRpc2FibGlu
ZyB0aGUgd2FrZXVwIGJpdCBpbiB0aGUgYm1BdHJyaWJ1dGVzLCBidXQgSSBzdGlsbCBzZWUgcmVt
b3RlIHdha2V1cA0KPiBiaXQgYmVpbmcgc2V0IGluIHRoZSBMUE0gdG9rZW4uIEZyb20gdGhlIG9i
c2VydmF0aW9uIGl0IHNlZW1zIGxpa2UgdGhlcmUgaXMNCg0KVGhhdCdzIGJlY2F1c2UgdGhlIGxp
bnV4IHhoY2kgZHJpdmVyIGVuYWJsZXMgcmVtb3RlIHdha2V1cCBiaXQgaW4gaXRzDQpwb3J0IHdp
dGhvdXQgcmVnYXJkIGZvciB0aGUgZGV2aWNlIGNvbmZpZ3VyYXRpb24uDQoNCj4gbm8gY29ycmVs
YXRpb24gYmV0d2VlbiB0aGUgd2FrZXVwIGJpdCBpbiB0aGUgYm1BdHJyaWJ1dGVzIGFuZCB0aGUg
d2FrZXVwIGJpdA0KPiBpbiB0aGUgTFBNIHRva2VuLg0KPiANCg0KVGhlIGhvc3QgY2FuIGJyaW5n
IHRoZSBkZXZpY2Ugb3V0IG9mIEwxLCB0aGF0J3MgcHJvYmFibHkgd2hhdCB5b3Ugc2F3Lg0KVGhl
IGNvbnRyb2xsZXIgZG9lc24ndCBpbml0aWF0ZSByZW1vdGUgd2FrZXVwIGJ5IGl0c2VsZi4NCg0K
VGhhbmtzLA0KVGhpbmg=
