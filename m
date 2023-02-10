Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538696916AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBJC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBJC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:27:49 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4527D7C;
        Thu,  9 Feb 2023 18:27:48 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A04210010027;
        Thu, 9 Feb 2023 18:27:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MrN6EOdZd0TKDM/f32c+xUm5TDju54nSpmXaTPpVejc=;
 b=EkE6/1iGkOngmvkTfQ2s/LTBENdlfBMw7Z9jXfoyNnfd/qpvDNW2Ew0VWuYWL0H6fncd
 xxRUYVbmZd3sGNzLUxjjLWUYDQ6heF+0D1Dbub8eYD0ewNVXrTUypvYecAYyGweB6KSW
 WUICRKkt2MNrQmbxvaUO1RYMdkWOoJCF9CHBXKt2fCI/cmLhfK9/rY5tdZBDW6WxQIpb
 ctyS47qtsc8cy6ANZ+wl6Cny30iTLly74tHP8952SuhGjEYo4yHmh0AP7+vaxwO9uvMT
 wegjAFrgjM8ZVWz/5laCMzRRHW0wE/PaajiSrymZhXSkdY7QLy38Ua0w7Q4pGzKPLdjK 7Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nhq61y76r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:27:35 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 275F64007C;
        Fri, 10 Feb 2023 02:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675996054; bh=MrN6EOdZd0TKDM/f32c+xUm5TDju54nSpmXaTPpVejc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NR7AaUPf8x+jVSwNQH5EDA3DfMZurXeqRsW7DlpCrvEjAbW7W0WuogsVW4aWcHvSu
         6IVZiZ+0FDjr8SurMh6FEl8kRVqrq2H4satdQQiySYJXRzFIcyVkixinbizn3YRdKY
         lD1HzK6ReCIlaxOfMupbMdUrHHxKMHWUrFQhBXNCjULOAh3upD8dx7HfG8zXK/mG5F
         9jz3NfaKDG8KtRYklP/dDz9heThzVoEkLrE2+EiwUseQmqIZc77Jz6RN+HXhaTUSxl
         a6rE5mkzLa/aQetLqC+k8HidVQfIgz9spULhasRLNJss1q7nsrrZfQUSSSb2qIaEkF
         GvNWrhH/kifyw==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3CBDEA0062;
        Fri, 10 Feb 2023 02:27:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1369A80202;
        Fri, 10 Feb 2023 02:27:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uKrxj00f";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlyGSzQI90IZ+3rOKZ9uwhga9oRzKKEQttW4E5D41qcMRfbcBwzvgSgl1DslTJX8W93TYi9ZVEyRhoWe28p8XYCluH4xVuWh/pvmGnANM+LdBBqJpIUij/eCyPgk4abs0nXWvINffHd78lX9E5crJKnmwwb8HX96sY2gcD6SW+rO2h2ADFFAJv0E9znzo6S/EgayJvkXJdw9EIzNnYKMK708yxPcWLX1Fw0ef49CYNJajjmhMafaENTwTsUMMvWJ93dfcsTuIcRtjFvBMtbCWSfrk7l+glmgMizdjB61C1B0u6nbYL+p/fF60/uEBGELCXcnhhvzE/gFllNA3N667Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrN6EOdZd0TKDM/f32c+xUm5TDju54nSpmXaTPpVejc=;
 b=SJvgxxF/sLw8v3DELpqB2R8wIcRNiWW98EgvE4AGmhMWNLPFzUxpADypZgvQWJTYCxTr+YQxRsawTL2Uog3Rlpn/2rU8rSvJZTorjqmVqy8CFb4ee3wxl07e8WmOTkRLJUv/LKXl7gTdRAOSkVpYEWnl8EgiCzqRZhHfzZxY+jV4I37rNUDKlR3nH+/b2TwSgATOemnhDwhIxAtctn0QGbqwTawcWEZjZCux7ZtJoeQsvFwP8Jwc6/NWd0KimKUfPYTvIE9YzA4uRmbvjr0ap0xewE8XI39DU+4Kk36CypaRpHoGVRDKxqhY7OpmFL1BbEfGYStoCyNNUzH7RVmymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrN6EOdZd0TKDM/f32c+xUm5TDju54nSpmXaTPpVejc=;
 b=uKrxj00f/zgHY2f4YIajCwbwnD8g3GBSC+Y+9PbHY36j8K3vyPPRAq1XqjTvynSm5zcSRVVFyWGLH2EQBNM4qH670M8EJhGFfPGQ5/4Ox2wASBUb1k7bhJ2cJQ+xnKh/C99ZxmuHKa276vYD7x45p8woL1HH0UOEffJHVtxSrkE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 02:27:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Fri, 10 Feb 2023
 02:27:28 +0000
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
Thread-Index: AQHZOl8gO3KZIGBpqkaJFw/1xTLpFK7CpxCAgAFu9ACAAClzgIAAC6eAgAAFcICAAxregIAADjuA
Date:   Fri, 10 Feb 2023 02:27:28 +0000
Message-ID: <20230210022719.ktggsykndv4k7i42@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
 <20230208011017.47o7m3xt63lbih3m@synopsys.com>
 <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
 <20230208021127.syauhdtpbyyncixr@synopsys.com>
 <28322f07-de6b-81e0-38c5-c856d5ce2dce@quicinc.com>
In-Reply-To: <28322f07-de6b-81e0-38c5-c856d5ce2dce@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4531:EE_
x-ms-office365-filtering-correlation-id: 1b0476c3-3752-4a70-0cc7-08db0b0e5b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuVWbjAE9nZEpsEMfgHtxFOpTg0HBOOuuE2v+JTFE+pVqrb4A6qL9SFZ2alkwWipCEGCzz59657VOFe2vGWjpMkDz1osfDuoAGswyzsOkbRmerDXDox4p1erNQzIxVgP+vnMfJUR/sjTPwCESn4wtHs8PWZDZYMoeJT78uGv/GoRzz+3vlBP0gs7nRwubAiH41i4fP2n8A3AJZM0EowGfK/10ezWMWbORtI95McpCN6Aq7Qxf/0diBpx1aTWN2e9EM+WOEcn0r7UYuTf7TC+dwCTTN5zc+ULn9479MauQoSKVSUKZW8UlZmWthlMPmDHCTdC5niLpIfVNSsHo28ND6/w0iSoeH1R2IZXD0/BKC5SV/T9kPzb/TqWMIzds/rnjSWrsgdIyW/NjOd8iMRD+I1ct3bp20gYrE0YE1IEoCVBHHwDluZERASPHNi2M/TwZjpfyptdraDisGgn2detH2VrLzBkVEFVG4Uq/Ex4fUB0YWAzl3Cspu5gKUUeWzOpsEbm0ks8n5cGqb05fSXlrF/8wH9sNLEWQlZcpG/Z2w16hvlJ8Q95A8Wq1tcJeZfvuqhXA8C79BTtYpOAmBIRbVIQKnPhY3qeBGEo2V27yYgGg3GLNXimtA8Z4w09nvgrli5vaPKUL/5zkqR6kLEnMDchUnElhEeZMts42PDmyBINZ0yCecNY+FfuI182mewsx+O62Y0lg0W7zOeSJeiB5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(71200400001)(36756003)(2906002)(6486002)(478600001)(2616005)(53546011)(6506007)(26005)(1076003)(186003)(6512007)(83380400001)(8676002)(6916009)(4326008)(66556008)(66476007)(66946007)(66446008)(41300700001)(76116006)(64756008)(5660300002)(38100700002)(86362001)(8936002)(122000001)(316002)(38070700005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0FUMlNmakJMeWp3elFaZFpWNGFTWmlJWnZUS2xmWjBiMGhyWVp6czdseUZ2?=
 =?utf-8?B?WDRBYVdnQzlLb08xYzhVMTEvMFRKNklZSDBDY01rajFMQldDS2RQUkZUZjIx?=
 =?utf-8?B?eE5KMVZhUHdwSStlaXhubXhBcHFBRXV1Mkkxa3lIejZQazJveUxMR3kwUXQx?=
 =?utf-8?B?Q0xONW8yM25qbGhIT2ZYeDdBc1JIV1R3dzhSdHIrOXMwa2Z3NEhrcDZPMU9u?=
 =?utf-8?B?b3lvaGpNdUQwNDRzSkV6LzNwRUZqUFdpdTEzQW4zcFVGRDhROVVnUk1mclNx?=
 =?utf-8?B?NWdiRWVSRVUxSXRtQ3N1azdrT3loMkZ2akwzL1JlL2I5aXVxd3JDMEJ6YThD?=
 =?utf-8?B?cWpDQmVlYjh6bS9QaDhZWTJFS3VCaERld0tiOHl5cDU1bVRxY1FXWkJ6blVu?=
 =?utf-8?B?RWFUKzJzR2QrOC9oSzlLdVJ4VDlqTzlIQXJ0NE5sWmxtTlFKYkFoVzlsR0ND?=
 =?utf-8?B?N25GcVhRbGExV2pOZ2pYa3FHUEZQTWVvSGlzVlZ2ckIzZm5IRm5iUEJSM1Fj?=
 =?utf-8?B?MU8ybExoenhvc2hmc0NLL0toOFdJMTBhN1gzY2xIK0R0OE0wM2dMM0cwditu?=
 =?utf-8?B?RFNjZ1lEb2ZERDBzTFJGTVZKWEpzOTFEOFgwTHpCNnZaR2tMa1JBYURjaTlw?=
 =?utf-8?B?VGlTSlYwdWg3WS9TMU8zdUFQMDQrTU5sRytsTjJiSm1sTFpNWnYwZ1dJaGVm?=
 =?utf-8?B?MDhuVmNJQkxUVlRyQ1lUbWVzUzVkczEvS2xzUitEYlk5VzdFeGNvcUQ2Vnla?=
 =?utf-8?B?eGJ1aVpHMDFueFpabG9TMjh2eThQMU1sYlBZMVRHZWtEV3hhQ2t1YWplL0wv?=
 =?utf-8?B?aHk3YVphRkhNZnVoZzkreDFTSXdDeVZnMEc3MDZLeFJod3E4dFo5dnExSUZv?=
 =?utf-8?B?VEQyR0toS0tHZ3BxQS9sSUpwWStKS2swWkpBRFU5V1BhRGpVZWQ1Q1hnSjNP?=
 =?utf-8?B?b2JHdm1XZUUyR3h3YTlCYWo1QThMWEw5cE1YWGRJQ1E3UmNwdDNCaXV0UkF5?=
 =?utf-8?B?bVN6OGpJWDNFK1l1L0YxZElEU0VpZlo0bkx5WHpHbDNMak9YUjNBTE9BbFJQ?=
 =?utf-8?B?bGdIQ005aFR3NVFKaHVmWU1JczFJUVNveFFYbHprLzNJT1Fzdzg1OUwvYlh0?=
 =?utf-8?B?MHdmUUJEYVZESE1rbmFmM3BBOXZlL1Y2VnR4U3ZqUXduUC92R3cwWXNuNjVS?=
 =?utf-8?B?R1ltc0ZKUjlhcWVHZXVuclE4NVdTVE1aWWR1aWZ4blNqd1ZlbERhb0toVUR0?=
 =?utf-8?B?ajc4NTlldkg2SmtxWmxsYXdhRW5JYkNidkN3RTZ4OFFYTVlqNXdHTzluWFE3?=
 =?utf-8?B?TGl6Y05WTC9iN2lRYWhuSkFUdlpDYXRlN21GMGZHcXJUb2c0WDVzdWVLb1p2?=
 =?utf-8?B?VGhmTXM1Z0xCRlEzSmk3Q0Vya1puc0hIWE1pWXZyb0E5Uk1hdzlDL0hJUzJK?=
 =?utf-8?B?NlVGZGlHdTRobkRWMk5wZUZoVVk0SzdkanJkT2FpNktHbWIyY2Y4aWJ0OUtr?=
 =?utf-8?B?YndJSkNrOW13QitKek9iY0JuM3hTYXk0RlJYcVN4NDVPdEJheGthcFNZN0tF?=
 =?utf-8?B?SlZRQ1JYUDBwU2tDbzBXa2RFYS9ZdGpnbnFlbFoyTVJOVlA0bWdCSk9JVXBT?=
 =?utf-8?B?aTdGUlhmWStkMzNpYUEvdjdYMVlsaVBnNDB3Ti9OR3N2c2wrMmRuWitsS3o0?=
 =?utf-8?B?Q01sZG5sN3o0V3llajFoVXRDWVdNRHRRVEFRM2hUT01aMFJnUS9EOGx6STMw?=
 =?utf-8?B?b0pvSlJySmFLRHhFeUduT1NnMEhlOXFZWTZwemFEaGVJWnV1WkloYUk0b3NT?=
 =?utf-8?B?RVFvcnlsVVRTeGcrRkkvOUJhYkNPNS95R0FNTUF5UzdRektHTjlDK1gwRmlZ?=
 =?utf-8?B?TFp4d2pXWFJ5aFlMUzhqQ25Pb3dIZGkzOHhpalBaemUwQjFMYlhhdW9XcTFE?=
 =?utf-8?B?NjVZT3JyWkE3NnNJZSsxblJzRlZaTjFRencybFVVLzIyVFlHZkNwTWlYZUVJ?=
 =?utf-8?B?WHVzWVZHVHN1M09CWERwZTZBTU92elB3dkhKWjJhNEpWMUIvdUVrV210OURR?=
 =?utf-8?B?VG5mMG5Wb0xXUWxaOFpmSnBQVUVTQWlEeXltZ091eUlOOEswSWExcFd0bE5R?=
 =?utf-8?B?Nlpxb0FTM1FzZVZYWEt0UG13Q0ZZTkFDUy8zTjcybXEzUnhIbHZLaXB6WXdp?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E4CDC33F2AC14687B11E0098A1717C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R9GEQuW3Mi7h8QhKqP6RXRwAD69hjQMfLSKcEDL/dcHum8E+ghxeIuerlART0UizI8ZhX71LLg33HtYHGmQeKbvjcunQTWIqReyX7Cg1OUgjmoF4HARFLr3nI4nP7t/6JuL3CKNo1MjBfRM73pSKMBYCzAPWgqNBpPkP9ZhbrTofLE8epTsQIrDQQVOMZ/z59nHj98+hH7NbQ/R5DwU60OrgAS1eWkOMJxwBxVhd6GJp8kPZhAMigEQRBuNeX06XeQptSAY/fqT2ziN3VTA/NVurN9QDajmcpMvcprUmF9uI1rPabFYn02ogcwTiFsV6FGDbLPW2fudTO8AMewcWXBGVqBJ8LrciPuekTr/CqVvfa9uuP9pHwgZxupIYsKizaLVR0Iy8MrTsPTikQdnDFwAQF32l6zkYIK7EFSGHOG97EI8sYJWpIg2RnXACO7KCj/YRnzx9oyfsDgCdVJeL+55yrjjUG6WKG90xl5KegS2n5hBN8NEHbpHMCSumoybDVnV4wfC6JstCn3+t1OHBxqCGyHzvJak5mDg16xks1qEY62XN+qtPFEvcBeTeSyCzxhUJoJAy77B6Dso1wqPzRRAXHFqSL6UWWfOmf56bgBPNV2lTJ8oMLvTHmGr2KeIXlZIc3I9mrfoe38U5N3fIStAxnJrpQe40US/UCYFk05Z7uaiaddG4UZC+SoMx0/mX7gpmv7FSxMZWUldcdfgkO3XdcsW9UumShM41uX56CrwDHaqA/068gn5YBkZqYE3dh4HRvwORJaFG4Sm7GQgUuaJ9jPHgpU3HDdkE0XXGIpxSD2biv8fqSA51DUXWMTKc3Ug+CPPzazugLufQgaN+LD4CfHf7MDqeIuPvxLHbOIkvL2b9B3plhm03tQJMXzSZXxrQs/+6PxAsyy7NpyG4M7my0FFappBsD/l1Ugf1ejE=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0476c3-3752-4a70-0cc7-08db0b0e5b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 02:27:28.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oh06dQ5s8FBRt/eGefryP0Glm9unL0WypoxaqofMeASlmVD3gWkZ/f7Sn2jQiPL51JccPsICybU3mTxtKM/B2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
X-Proofpoint-GUID: DKHl-kiFqltGZT84mW8ANehJfONb7pG3
X-Proofpoint-ORIG-GUID: DKHl-kiFqltGZT84mW8ANehJfONb7pG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMDksIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAy
LzcvMjAyMyA2OjExIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVHVlLCBGZWIgMDcs
IDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiAyLzcv
MjAyMyA1OjEwIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgRmViIDA3
LCAyMDIzLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gT24gMi82LzIwMjMgNDo0OCBQ
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiArc3RhdGljIGludCBfX2R3YzNf
Z2FkZ2V0X3dha2V1cChzdHJ1Y3QgZHdjMyAqZHdjLCBib29sIGFzeW5jKQ0KPiA+ID4gPiA+ID4g
PiAgICAgew0KPiA+ID4gPiA+ID4gPiAgICAgCWludAkJCXJldHJpZXM7DQo+ID4gPiA+ID4gPiA+
IEBAIC0yMjk2LDkgKzIzMDksMTQgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3dha2V1cChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiA+ID4gPiAgICAgCWxpbmtfc3RhdGUgPSBEV0MzX0RT
VFNfVVNCTE5LU1QocmVnKTsNCj4gPiA+ID4gPiA+ID4gICAgIAlzd2l0Y2ggKGxpbmtfc3RhdGUp
IHsNCj4gPiA+ID4gPiA+ID4gKwljYXNlIERXQzNfTElOS19TVEFURV9VMzoJLyogaW4gSFMsIG1l
YW5zIFNVU1BFTkQgKi8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSXQncyBhbHNvIHBvc3Np
YmxlIHRvIGRvIHJlbW90ZSB3YWtldXAgaW4gTDEgZm9yIGhpZ2hzcGVlZC4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSByd19jb25maWd1cmVkIGZsYWcgaGVyZSBpcyBp
biBjb250ZXh0IG9mIHRyaWdnZXJpbmcgcmVtb3RlIHdha2V1cCBmcm9tDQo+ID4gPiA+ID4gYnVz
IHN1c3BlbmQgb25seS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgcmVtb3RlIHdha2V1cCBz
ZXR0aW5nIGZvciBsMSBpbiBIaWdoU3BlZWQgaXMgY29udHJvbGxlZCB0aHJvdWdoIExQTQ0KPiA+
ID4gPiA+IHRva2VuIGFuZCBvdmVycmlkZXMvaWdub3JlcyB0aGUgY29uZmlnIGRlc2MgYm1BdHRy
aWJ1dGVzIHdha2V1cCBiaXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2VjdGlvbiA0LjEgb2Yg
VVNCMl9MaW5rUG93ZXJNYW5nZW1lbnRfRUNOW2ZpbmFsXSBzcGVjICJUaGUgaG9zdCBzeXN0ZW0g
c2V0cyB0aGUgUmVtb3RlIFdha2UgRmxhZyBwYXJhbWV0ZXIgaW4gdGhpcyByZXF1ZXN0IHRvDQo+
ID4gPiA+ID4gZW5hYmxlIG9yIGRpc2FibGUgdGhlIGFkZHJlc3NlZCBkZXZpY2UNCj4gPiA+ID4g
PiBmb3IgcmVtb3RlIHdha2UgZnJvbSBMMS4gVGhlIHZhbHVlIG9mIHRoaXMgZmxhZyB3aWxsIHRl
bXBvcmFyaWx5ICh3aGlsZSBpbg0KPiA+ID4gPiA+IEwxKSBvdmVycmlkZSB0aGUgY3VycmVudCBz
ZXR0aW5nIG9mIHRoZQ0KPiA+ID4gPiA+IFJlbW90ZSBXYWtlIGZlYXR1cmUgc2V0dGFibGUgYnkg
dGhlIHN0YW5kYXJkIFNldC9DbGVhckZlYXR1cmUoKSBjb21tYW5kcw0KPiA+ID4gPiA+IGRlZmlu
ZWQgaW4gVW5pdmVyc2FsIFNlcmlhbCBCdXMgU3BlY2lmaWNhdGlvbiwgcmV2aXNpb24gMi4wLCBD
aGFwdGVyIDkuIg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiBJ
IGFtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXQg
b3ZlcnJpZGVzIHRoZSBzZXR0aW5nIG9mIHRoZSBTZXRGZWF0dXJlIHJlcXVlc3QsIG5vdCB0aGUg
ZGV2aWNlDQo+ID4gPiA+IGNvbmZpZ3VyYXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgcndf
Y29uZmlndXJlZCByZWZsZWN0cyB0aGUgdXNlciBjb25maWd1cmF0aW9uLiBXaGV0aGVyIHRoZSBo
b3N0DQo+ID4gPiA+IHRyaWVzIHRvIGVuYWJsZSB0aGUgcmVtb3RlIHdha2V1cCB0aHJvdWdoIFNl
dEZlYXR1cmUgcmVxdWVzdCBvciBMUE0NCj4gPiA+ID4gdG9rZW4sIHRoZSBkZXZpY2Ugc2hvdWxk
IG9wZXJhdGUgd2l0aGluIHRoZSB1c2VyIGNvbmZpZ3VyYXRpb24NCj4gPiA+ID4gbGltaXRhdGlv
bi4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHRoZSBjb25maWd1cmF0aW9uIGluZGljYXRlcyB0aGF0
IGl0IGRvZXNuJ3Qgc3VwcG9ydCByZW1vdGUgd2FrZXVwLCB3ZQ0KPiA+ID4gPiBzaG91bGQgcHJl
dmVudCB1bmV4cGVjdGVkIGJlaGF2aW9yIGZyb20gdGhlIGRldmljZS4gRm9yIHNpbXBsaWNpdHks
IHdlDQo+ID4gPiA+IGNhbiBqdXN0IHJldHVybiBmYWlsdXJlIHRvIHdha2V1cCBmb3IgYWxsIHN0
YXRlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gVGhpbmgNCj4gPiA+IA0K
PiA+ID4gTDEgZW50cnkvZXhpdCBpcyBIVyBjb250cm9sbGVkIGFuZCB0aGUgcmVtb3RlIHdha2V1
cCBpcyBjb25kaXRpb25hbC4oU2VjdGlvbg0KPiA+ID4gNy4xL1RhYmxlNy4yIG9mIGR3YzMgZGF0
YSBib29rKS4gRXZlbiB0aG91Z2ggd2UgYmxvY2sgaXQgZnJvbQ0KPiA+ID4gU1cgdGhlIGwxIGV4
aXQgd2lsbCBzdGlsbCBoYXBwZW4gZnJvbSBIVyBwb2ludCBvZiB2aWV3Lg0KPiA+ID4gDQo+ID4g
PiBUbyBjb3JyZWxhdGUgdGhlIHVzZXIgY29uZmlndXJhdGlvbiB3aXRoIExQTSB0b2tlbiwgSSBl
eHBlcmltZW50ZWQgYnkNCj4gPiA+IGRpc2FibGluZyB0aGUgd2FrZXVwIGJpdCBpbiB0aGUgYm1B
dHJyaWJ1dGVzLCBidXQgSSBzdGlsbCBzZWUgcmVtb3RlIHdha2V1cA0KPiA+ID4gYml0IGJlaW5n
IHNldCBpbiB0aGUgTFBNIHRva2VuLiBGcm9tIHRoZSBvYnNlcnZhdGlvbiBpdCBzZWVtcyBsaWtl
IHRoZXJlIGlzDQo+ID4gDQo+ID4gVGhhdCdzIGJlY2F1c2UgdGhlIGxpbnV4IHhoY2kgZHJpdmVy
IGVuYWJsZXMgcmVtb3RlIHdha2V1cCBiaXQgaW4gaXRzDQo+ID4gcG9ydCB3aXRob3V0IHJlZ2Fy
ZCBmb3IgdGhlIGRldmljZSBjb25maWd1cmF0aW9uLg0KPiA+IA0KPiA+ID4gbm8gY29ycmVsYXRp
b24gYmV0d2VlbiB0aGUgd2FrZXVwIGJpdCBpbiB0aGUgYm1BdHJyaWJ1dGVzIGFuZCB0aGUgd2Fr
ZXVwIGJpdA0KPiA+ID4gaW4gdGhlIExQTSB0b2tlbi4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoZSBo
b3N0IGNhbiBicmluZyB0aGUgZGV2aWNlIG91dCBvZiBMMSwgdGhhdCdzIHByb2JhYmx5IHdoYXQg
eW91IHNhdy4NCj4gPiBUaGUgY29udHJvbGxlciBkb2Vzbid0IGluaXRpYXRlIHJlbW90ZSB3YWtl
dXAgYnkgaXRzZWxmLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiANCj4gQWN0dWFs
bHkgaXQgc2VlbXMgdGhlIGNvbnRyb2xsZXIgaXMgaW5pdGlhdGluZyBhIHJlbW90ZSB3YWtldXAg
YnkgaXRzZWxmIHRvDQo+IGV4aXQgZnJvbSBsMSB3aGVuIHdlIHNlbmQgYSBTVEFSVFRSQU5TRkVS
IGNvbW1hbmQuIEkgZGlkIGJlbG93IGV4cGVyaW1lbnQNCj4gd2hlbiB0aGUgZGV2aWNlIHdhcyBp
biBIaWdoU3BlZWQNCj4gDQoNClRoYXQncyBkcml2ZW4gYnkgdGhlIGRyaXZlciB0ZWxsaW5nIHRo
ZSBjb250cm9sbGVyIHRvIGluaXRpYXRlIHJlbW90ZQ0Kd2FrZXVwIGFuZCBub3QgdGhlIGNvbnRy
b2xsZXIgaXRzZWxmLiBXaGVuIHdlIHNlbmQgdGhlIFNUQVJUX1RSQU5TRkVSDQpjb21tYW5kLCB0
aGUgZHJpdmVyIGRvZXMgcmVtb3RlIHdha2V1cCBzbyB0aGUgaG9zdCB3b3VsZCBicmluZyB0aGUN
CmRldmljZSB0byBPTiBzdGF0ZSBzbyB0aGF0IHRoZSBjb21tYW5kIGNhbiBnbyB0aHJvdWdoLg0K
DQpIb3dldmVyIHlvdSBicmluZyB1cCBhIGdvb2QgcG9pbnQgdGhhdCBpZiB3ZSBwcmV2ZW50IHJl
bW90ZSB3YWtldXAgZm9yDQpMMSwgdGhlbiB3ZSBoYXZlIHRvIGRlbGF5IHNlbmRpbmcgU1RBUlRf
VFJBTlNGRVIgY29tbWFuZCB1bnRpbCB0aGUgaG9zdA0KaW5pdGlhdGUgcmVzdW1lLiBUaGlzIHdv
dWxkIHJlcXVpcmUgYWRkaXRpb25hbCBlbmhhbmNlbWVudCB0byBkd2MzIHRvDQpoYW5kbGUgdGhp
cyBzY2VuYXJpby4gRm9yIG5vdywgY2FuIHdlIGlnbm9yZSB0aGlzIHNwZWNpZmljIGNhc2Ugd2hl
bg0Kc2VuZGluZyBTVEFSVF9UUkFOU0ZFUiBjb21tYW5kIGFuZCBvbmx5IGNoZWNrIGZvciB0aGUg
Y2FzZSB3aGVuIHRoZSB1c2VyDQp0cmlnZ2VyIHJlbW90ZSB3YWtldXAgdmlhIGdhZGdldC0+b3Bz
LT53YWtldXAvZnVuY193YWtldXAuDQoNClRoYW5rcywNClRoaW5o
