Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F286D8C24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjDFApw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDFApu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:45:50 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72501BC1;
        Wed,  5 Apr 2023 17:45:48 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3360CbAB016751;
        Wed, 5 Apr 2023 17:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=hxhWkvtQ5cXZj63neatDtsWzmXyZEPGwUOmDTM6vfI0=;
 b=sdx2MVratqihaiTIgL4LksBzgTRVqSPo7deTNX8l6nDLvBBFpBHD1q46kjawTedPRa8/
 pafk9x5mqPUb1iodCRz8/RcRjjoAUNfv54g7R12LotpUb45WKMpKt+mZEK3cepBS4F2P
 p+712qH1f0bt62nmh51OINqxY3ybQAbstgrCzlkBycT5qyvmby6IPpE99oDZooQ7ZnQk
 Jyw0j6GQlyarI5JUdv+zLu2YPZiJsPjjIMyCjv30VqRcSepYwCrvMsFqc2e1f0xcvWsC
 4YX5bejYYYgNwyEAggw5gGQ/HTx16KvqeZKU4Y7E0D6zFwFFkHKnh7eq2E0Xv4D2O+f6 YQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhxt0fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 17:45:24 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5DA59C05B1;
        Thu,  6 Apr 2023 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680741923; bh=hxhWkvtQ5cXZj63neatDtsWzmXyZEPGwUOmDTM6vfI0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QIZdq6it9Ltp/U5ric1FuxKKgV3PYjV9ThnBke4TJ7OeoQcmpsLkM5JhC4HdcagMk
         OoLlFUXN4XN7uClugMWnPgmCTf16bxu4XOAVklnckWgRP/MWVhadjOnNueO0sgC5BT
         ZtcqwDwfybBGYZZnXJXtkRj/6mOyOTbtRxvqKLE9/DFo5cPE/5qPvWtRdgwvzNqDyl
         s6BiwFM6vPhRvmK/76SyP7RpX0M/1U+dTPObtx2P3h8o/SOqsR3jOrFSxYjxSmjf3h
         /9787PUgL80yjeeN4qahrGcaWOUTzVCaR4SfOdM5uz3GTKGdFfXVp9N07+blieBcU2
         I8SrIulZ3IrIg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 70EABA006F;
        Thu,  6 Apr 2023 00:45:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C4B30800EE;
        Thu,  6 Apr 2023 00:45:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QLy0GBHK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQQaDg33icVEfV4vp22GQvugqKwSNcuKYvhqFJn9LXSegulS70cteaFrVe5FK14LR62ff6t/vsiCqMrQkcMD01i6biz0JyoY+HbOodGoIvyY7fVtWeZHDkGr7Er/8ZXRzIoC5pljbNwD06GULJT4SX3dBcgsjLSeTLDkrb4a/HfdNy+Ai7wFv3h+HTMm69FUOnjL1SSuWzI1YerdIE4KJebsl+gynbfa9qwj/I6eBlIuf1H8iOfNgbsjTj2clt+bIq1lhrstc12dQl0YYyuJm8KHE61Vj66Y+wv5TJre4oKr5mlKzBMjMeeB/zPKDAnbZ3SC6hWoPcji4/CrudU2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxhWkvtQ5cXZj63neatDtsWzmXyZEPGwUOmDTM6vfI0=;
 b=hcFeqYYPr3I2EmmP0L6F64LSHIkFsuxyMSrg3VC3OZLJDgTu7l+LRAV3n0rIY7qujEIMII2xYzLWQ/okwOyztTuz1LdVz/1kHap5QSYgJ4ivjOVLPyLnA7ZqR7bI34BPJpVV1Qgb650Su563Wn80Au9BWA5cN3Sy2bHS5FfSJkT57APeYd88SFTe/UjvJJIkc6I9uaAiRT9sVsM3OgYuJ8uc+JSV+KAILvyO82RMaQV5eelQBZC/wjbQ+MTIUxDWPYI4R+NFhnt85Uf7Cwzfp2rjv3AlX/S7WXArarWcuaIyP7HpBE29PdlSEwwEIEXXJ81rOrINPC+00IvmYlFzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxhWkvtQ5cXZj63neatDtsWzmXyZEPGwUOmDTM6vfI0=;
 b=QLy0GBHKzmr3Y1J+6of9g0TfIT7aIKcXiHfOooiV38Pv2QMmpavTRmWPhqxGPQcIh9iVTZE+URLXGGo+lQQfvCcX998r4Pq74KwmzFyK/gwDmNKE4u39fo9B9RJZOrCUc0Z7g7Yo8lwTNsENLlsgwODNBeUiUR3VDX9FXpKTeb8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:45:15 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 00:45:15 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgIABGcUAgAa8LoCAAFDhAIABHkyAgABv8wCAAVUPAA==
Date:   Thu, 6 Apr 2023 00:45:15 +0000
Message-ID: <20230406004510.yxoxby2rwkalpqlh@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
 <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
 <20230403234937.sotn3pznu4winlkw@synopsys.com>
 <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
 <20230404214347.mi6rmksr7pym74rp@synopsys.com>
 <f334b8b9-b8d8-240d-5ace-bed255f4609a@quicinc.com>
In-Reply-To: <f334b8b9-b8d8-240d-5ace-bed255f4609a@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB8520:EE_
x-ms-office365-filtering-correlation-id: 2a8d54c4-b0a2-4d2f-304f-08db36382fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N79bzDvFfLRy8nPXAy1oEpaa9fi7O+xlpfXmsLDK7p6EtITPUgMYkuTu2Uo6Xuqs9SjIqGC3iqPADiDArkCp8CiWfrQpth8oba5xa2k8DekzD6t9FivoTZr5mRh02Y8PT2n3LaUla4XTAR57z08V70YDZHRoicLrYUTQRbcV2pi2MWf8FIzuCJmWx5Tr0vspMgrNR31/kfjixp7SgY1A8+zY9AuwD80JVPgfg0q06dJEbL7oOZav2AqvIO3fa3zmB5D2M5d4HNsz0rbEl/I8K63jmsW4AzYa8WOvAZOMS8shMovjA3TejqDAblbCH8/oZXgD7EtpDO4qBKdDS/WWyjydS7phHUpvbLuFVVEpmyje7hjuStMbIvmQ1lYYafgjaR77U8OgD5SLR93mNAhSjmSoRv5UWi1hJxNwpYi/dW1RpgdeFduQKboXMnDYz/11rYjqEmKs24MfoNc5y/IYRpB6hTGHIUlAgTqnLaR5RYTc3j+OJVyoJbDZUlYiBWBHyvFAEbFEsg2Xer7DcahLowGBqszGAbUgvaKa11hMbcM1W/P+skp+pUg3fvb9+g0Tl8fKS8KSD+1Icl+oo2YgCspmCoKZ31y3nRm+8uaztb7Slp1EeeH1XAkeGFMNsepB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(38100700002)(2616005)(7416002)(38070700005)(186003)(8936002)(5660300002)(2906002)(122000001)(1076003)(26005)(53546011)(6506007)(54906003)(6512007)(66476007)(8676002)(66446008)(64756008)(66556008)(41300700001)(86362001)(6916009)(76116006)(66946007)(478600001)(4326008)(316002)(6486002)(71200400001)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2cvQ3A1eEFNQlZuUVY4cENYT242ZTNZeHl1WUFENmdjSW1IazF6cnhEdXIr?=
 =?utf-8?B?ZDd3VmpJMUlRd241b2t2L0FZUTF6b1hhUjZ5MDErVTVKcjI0d29zU2wxajV4?=
 =?utf-8?B?NEl0UG5mZ0lQN0l0Z3kzRmpZMFhpWG02Q3VZTFhSS1lCbjFFRGg1bmtOWFBZ?=
 =?utf-8?B?Rm9KMjJ3OHpETldSSC9lRzlHeXpyWVozNnJxTzRNSXlKNmQvZklmVGpVM3kw?=
 =?utf-8?B?bjFLUXFkWm1nTHFvZHkwYVl4T2owYTB4NHc1OWVPSVMvL2Q5OEZUY3NuODZ1?=
 =?utf-8?B?TW1DSnVkZm5zdk96bk8ybVB6bGhpbFN6VnlXaG5uVzFvdkFLdVhTN0VPZmFq?=
 =?utf-8?B?RzNtSkxXZmp5aXFaSm05STJEUU5BR1JhQ2MxL3NEWWwydURWY3RZWUhXeXZ4?=
 =?utf-8?B?cTdQSlBkMVozRXp3T2NJMjI5WUdqRGhZU0tSTUNHVFlaTWE0em0vSXQ1R3Mw?=
 =?utf-8?B?LzVubm83NGVyTHZtZWxsZFlSeTlBMXk1eTJWNXVOcGVtV1Fsb0JKTE5OZkNR?=
 =?utf-8?B?cTZZWU9WVzZ1VWNyVlV3SzhtaGlyZG5Lby9tVDhMcGNGS1BxeC9nK2YrQTRN?=
 =?utf-8?B?dVpDdG9GU1ZLYjkwY0k0b2pGalNJTWdlSlR0ZzAvT0E1QUo2akhPTUdJZm15?=
 =?utf-8?B?MlA5QS8wWWd1bUJJZWdhS1FscXlqNmVNYUZlaHp3T2tYR0hQQkE5R3F2Nk5W?=
 =?utf-8?B?Vmp4L0RRYTBiSUZhYUlBcUZBT21DUlVVVWczOTZvTS92VWtxNXB3ZnZHUW9s?=
 =?utf-8?B?a0RoQzBoNkwreHViYnk2NHk2Q1pPVnE2VDZmZXhsNjk5WlE3dmNKMENpMzBR?=
 =?utf-8?B?TzlnamRPSE1kYjcwM2NMck5iS3Y3MHFqVE1xMmJTbkF2YVNxbGZTSC8xYVFX?=
 =?utf-8?B?SC95ZWhOZFZWYVFnc1praW9MMG8xY05aektzL2M4bEJYbGE4aGxFRTQvQmpS?=
 =?utf-8?B?Y090emJDbW1TYTRvKzVkQnJYcEt4d1V5U0NOUlhLSUF6NVJVMFB5alNhN0o3?=
 =?utf-8?B?bHZ4Mk5OVWluY3FMcG44c0o0eW9KN2RyeDJZcXEwQ05hWjNMNmJBYzI5Mkhr?=
 =?utf-8?B?b2pxMzJvSWZPalp5T0F0WjdFQlI3OXRBNDNVYlYzYnBNZ3ZLM0VSa0tPM3lD?=
 =?utf-8?B?cWNXdjY3TWptMFJraHQ5WnAyLzFST1BXN0ZTbFQ5UnF1dEdOQTR6RzZMOVRi?=
 =?utf-8?B?VFZ4WDRaYVVQNFhPdDJiVVdZM0IyVzgwNG5sZEFROWgyQ2Nzc3Q2NUYybUg2?=
 =?utf-8?B?bHR6YVg0U1RqbjZQUWkvMzI3d0JUWGNnOGFPQWlPbDJaY3NGMmtFYkF0VThZ?=
 =?utf-8?B?ZXhxamo1V29xeEU3ditUaUx5TW16Qy9IK0VZWjBvMVFjUzd2MUd3OVlXald1?=
 =?utf-8?B?Lzk0QlJhMVBWTFBpN2dkYlUxVGZCN01GZVd1cFkraERLbzR4bUpiRmtVd3pQ?=
 =?utf-8?B?WFdXU2NzaWtOU0IrSU1DS04rd28rdFJvOVNYYjgyS3JEdEZlMCs2ZE5qWG9w?=
 =?utf-8?B?aHVLdmhLMVdUYUhBaWVEK3krang1SVV1YzZ1Q0F2RWlGYW1Va3U2WFU1T2tJ?=
 =?utf-8?B?U2VGVTNKWVgvRENjdjFNUG1pa3hzV2d1TUFTYlo5aWd3clBQZDd1eXY4OUcw?=
 =?utf-8?B?KzhFdDNxTjRrL3FsZEdJem5abzFLNjVITDVjbTBPUmJLRzJHRG5obVBURWRD?=
 =?utf-8?B?eExvYUI0TjlYcFZReWtxM2xyVW5zMFE0UitPRHBSTlNPeklFY05RdWhybFh5?=
 =?utf-8?B?ZXJWYktxcHFBMDFqb2xDY2liUjFJZloxU2lYeG1LMkhQNnh6VnNIUFl1TTZI?=
 =?utf-8?B?bTh1em81WlBFVkdLOVJRajVOOTI5azA4SkFsMG5EeUtPRkZhemwyaHY3eENP?=
 =?utf-8?B?dkNnQXhJdGZGaUxPSUdYcGJkN1FMYmV5UWFVTGJVYlhTMlllUHBvOEd4VHNy?=
 =?utf-8?B?bk5mcXNoNWhHYnhYVEFZYU40UzhRZWE4YUJOeTczNVVHZTdBRkREQ2NTQzRu?=
 =?utf-8?B?eXVUR2gyZExPMkhMRnZQaCtseEorYmphTnc0Y1J1VzYzekFoaHgwNHo4UlpO?=
 =?utf-8?B?K2FramdSbTk1SnVxWCtXQUhNLzRRRnhWcDIxL0l2eXpIMU91dGlsYXlUMDJW?=
 =?utf-8?Q?nWH28DiRA5c3j9RDfm0RxSzf4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40567531830BDA46B64B1A82F52E6F11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzJCVzFGMHB5QmxZV0EyZ1BXRSsrRUV2SDlkZzhiOERMS2gwdXpPbVVQSUl4?=
 =?utf-8?B?d3kvdWIvbkpmMTFQVFVZMk9nNUk4TXREUTJ3bXQzSXhBVUVhT2EwWUQrNHI4?=
 =?utf-8?B?VXZyanZtYlBQL25PNDl0TEp1M0IyZjlaMkNBSVYvdXlCMUVSN3hiSXZkcmVF?=
 =?utf-8?B?NEVUcG91T0tEQzAzRExscGhuUFMzaFBMWHdFMG1hMnlZYlVIVEVSMVBvNjlY?=
 =?utf-8?B?Vm05UTA5bEh2WHVER3BxWm5lUDBlT2FQdzh2UmlweXVvNjFZZ1NscThPNlJD?=
 =?utf-8?B?Yk5reG40QmVjVFVncHVLWHVBZ0wwWHpBdm9UNHgvaUxEY1V5T04zV3ByU1hq?=
 =?utf-8?B?QXFpTHJ3bjVEcktJQWdLWkpqL1pVQ2hIMlhESmVaUjB6eGlleVMyWjhvWVdS?=
 =?utf-8?B?NDNYTHl5aWsyWkpucExMWW4zcU5oZG9jL2hhb1VHSlJidmVVNmdscWdvTHJ5?=
 =?utf-8?B?UjJQTzd4NURlVmVnd3FwSUZ1OVVlZ1c2ZmlVMkVCVzdhL0NkdG02SmtLRFlT?=
 =?utf-8?B?Q3pYZU04UG10ZlVWWm5yN1JnN1ZkTFQwR1RMUFM5U01RVUFPdE9jd3RaZmFO?=
 =?utf-8?B?VStkQUZ0ek9TMklTcmtEK2lXV3hqSG9QdmVReHVjZkNtSEdaYVhrcWI3K2pv?=
 =?utf-8?B?TWpoTStyRDF0USttNnRiZDFERkc2ZzhzMEhmZTViUnZLL1Z3dWtaMG1EaEln?=
 =?utf-8?B?cTNKQ3pzUmh6bTJSa3AweGwyTmVwQk4xcTQwQXgzTGc3UWJ3eTR5TGYzYVFB?=
 =?utf-8?B?NWhVd01uRktpemFZWGFTbEFPa3MrODVMTThwUGhEWDU1akVUQTk4K3psMHU1?=
 =?utf-8?B?MU4yM0ZHWEZQUkxDRmdycllVeWtMN2IvR05ETHdIVkFoMlV1NFVnQkRIYnFC?=
 =?utf-8?B?c2NrWlpRd213Z0xuN2dHeVNzUkF5ajkxQ3Zpa0J1MWh5aG0zUkgwWXNTWmxC?=
 =?utf-8?B?bU5QY0RBQ2d3RGFSL0VKcVlFM2NsUWltRkVXUTlTUC9Cc3hlMjhPbTFRbzVX?=
 =?utf-8?B?eEkra0wyN1Q4dkQ3MVFpZWM2YXQwZ3FvQ3RsMzRabnZvdG9WSTdSbnFxU3A5?=
 =?utf-8?B?MS9QV2FsTUJHaS94ZEtWZFczSmZmL280ckhMUCt4WVZvWVMrZFBuN2hJbmZK?=
 =?utf-8?B?RHN6VDIvQklNMEN4T1U3RWdXdVlERFFzNmZEcENsakZ2RWpyTFE4RjR5Z1A0?=
 =?utf-8?B?ckYyRXZNd2hQNFl0a01UU01KOUJqZUdQKzdWQmR5RVo3SlovdnhGcUdTY09j?=
 =?utf-8?B?RFJqRDBpZzZ4UzFZejZPRk5YQ3lmSjhXZVVDallERHpiNzEyU0w0M3NNSldu?=
 =?utf-8?B?cnIvODM1Q09CYVhVRlV1TDRlRHhtZnorUi9tQ0czS0ppM0hSdHVPYm9wR1lN?=
 =?utf-8?Q?xeczdAZn/U6yrJIwH/FgwPZZ0TSdTN84=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d54c4-b0a2-4d2f-304f-08db36382fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 00:45:15.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6XiEEJZFG2dh7zQ5GYfJirxyFYEWxp9pnziHWUzxd8+eb14tBnvLgMbeNngoqRUQG0BPCsxgVKBhX8FRa6mqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
X-Proofpoint-GUID: 7KMyV6M5Ge--PKpsy3euavv8R5B_mIwa
X-Proofpoint-ORIG-GUID: 7KMyV6M5Ge--PKpsy3euavv8R5B_mIwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304060004
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMDUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNC81LzIwMjMgMzoxMyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgQXByIDA0LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IE9uIDQvNC8yMDIzIDU6MTkgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
PiA+ID4gT24gVGh1LCBNYXIgMzAsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gMy8zMC8yMDIzIDU6NDAgQU0s
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFdlZCwgTWFyIDI5LCAyMDIzLCBL
cmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IE9uIDMvMjkvMjAyMyAyOjUwIEFNLCBUaGluaCBOZ3V5ZW4gd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gT24gVHVlLCBNYXIgMjgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiBJZiB0aGUgY29yZSBzb2Z0IHJlc2V0IHRpbWVvdXQgaGFwcGVucywgYXZvaWQg
c2V0dGluZyB1cCBldmVudA0KPiA+ID4gPiA+ID4gPiA+ID4gYnVmZmVycyBhbmQgc3RhcnRpbmcg
Z2FkZ2V0IGFzIHRoZSB3cml0ZXMgdG8gdGhlc2UgcmVnaXN0ZXJzDQo+ID4gPiA+ID4gPiA+ID4g
PiBtYXkgbm90IHJlZmxlY3Qgd2hlbiBpbiByZXNldCBhbmQgc2V0dGluZyB0aGUgcnVuIHN0b3Ag
Yml0DQo+ID4gPiA+ID4gPiA+ID4gPiBjYW4gbGVhZCB0aGUgY29udHJvbGxlciB0byBhY2Nlc3Mg
d3JvbmcgZXZlbnQgYnVmZmVyIGFkZHJlc3MNCj4gPiA+ID4gPiA+ID4gPiA+IHJlc3VsdGluZyBp
biBhIGNyYXNoLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiA+
ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIGRyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCAzYzYz
ZmE5N2E2ODAuLmYwNDcyODAxZDlhNSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC0yNjIwLDEzICsyNjIwLDE2
IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBp
bnQgaXNfb24pDQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIAkJICogZGV2aWNlLWluaXRpYXRlZCBk
aXNjb25uZWN0IHJlcXVpcmVzIGEgY29yZSBzb2Z0IHJlc2V0DQo+ID4gPiA+ID4gPiA+ID4gPiAg
ICAgIAkJICogKERDVEwuQ1NmdFJzdCkgYmVmb3JlIGVuYWJsaW5nIHRoZSBydW4vc3RvcCBiaXQu
DQo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIAkJICovDQo+ID4gPiA+ID4gPiA+ID4gPiAtCQlkd2Mz
X2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiA+ID4gPiA+ID4gPiA+ID4gKwkJcmV0ID0gZHdjM19j
b3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiA+ID4gPiA+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4g
PiA+ID4gPiA+ID4gPiArCQkJZ290byBkb25lOw0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJCWR3
YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJCV9f
ZHdjM19nYWRnZXRfc3RhcnQoZHdjKTsNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgCQlyZXQgPSBk
d2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIHRydWUsIGZhbHNlKTsNCj4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgCX0NCj4gPiA+ID4gPiA+ID4gPiA+ICtkb25lOg0KPiA+ID4gPiA+ID4gPiA+ID4gICAg
ICAJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJcmV0
dXJuIHJldDsNCj4gPiA+ID4gPiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+ID4gPiA+ID4gMi40MC4w
DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJ
IHRoaW5rIHRoZXJlJ3Mgb25lIG1vcmUgcGxhY2UgdGhhdCBtYXkgbmVlZHMgdGhpcyBjaGVjay4g
Q2FuIHlvdSBhbHNvDQo+ID4gPiA+ID4gPiA+ID4gYWRkIHRoaXMgY2hlY2sgaW4gX19kd2MzX3Nl
dF9tb2RlKCk/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBIaSBUaGluaCwNCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICAgICAgU3VyZS4gV2lsbCBkbyBpdC4NCj4gPiA+ID4g
PiA+ID4gV2lsbCB0aGUgYmVsb3cgYmUgZ29vZCBlbm91Z2ggPyBPciB3b3VsZCBpdCBiZSBnb29k
IHRvIGFkZCBhbiBlcnJvci93YXJuIGxvZw0KPiA+ID4gPiA+ID4gPiB0aGVyZT4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gVGhlcmUncyBhbHJlYWR5IGEgd2FybmluZyBtZXNzYWdlIGluIGR3
YzNfY29yZV9zb2Z0X3Jlc2V0KCkgaWYgaXQgZmFpbHMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IGtyaXNrdXJhQGh1LWtyaXNrdXJhLWh5ZDovbG9jYWwvbW50
L3dvcmtzcGFjZS9rcmlzaG5hL3NrYWxlczIvc2thbGVzL2tlcm5lbCQNCj4gPiA+ID4gPiA+ID4g
Z2l0IGRpZmYgZHJpdmVycy91c2IvDQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gPiA+
IGluZGV4IDQ3NmI2MzYxODUxMS4uOGQxZDIxM2QxZGNkIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+ID4gPiBAQCAtMjEwLDcgKzIxMCw5IEBAIHN0YXRp
YyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICBjYXNlIERXQzNfR0NUTF9QUlRD
QVBfREVWSUNFOg0KPiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAgZHdjM19jb3JlX3NvZnRf
cmVzZXQoZHdjKTsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldCA9IGR3YzNfY29y
ZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0
KQ0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICBkd2MzX2V2ZW50X2J1
ZmZlcnNfc2V0dXAoZHdjKTsNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IElmIHNvZnQtcmVzZXQgZmFpbGVkLCB0aGUgY29udHJvbGxlciBpcyBpbiBhIGJhZCBzdGF0
ZS4gV2Ugc2hvdWxkIG5vdA0KPiA+ID4gPiA+ID4gcGVyZm9ybSBhbnkgZnVydGhlciBvcGVyYXRp
b24gdW50aWwgdGhlIG5leHQgaGFyZCByZXNldC4gV2Ugc2hvdWxkIGZsYWcNCj4gPiA+ID4gPiA+
IHRoZSBjb250cm9sbGVyIGFzIGRlYWQuIEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSB0aGUgZXF1aXZh
bGVudCBvZiB0aGUNCj4gPiA+ID4gPiA+IGhvc3QncyBIQ0RfRkxBR19ERUFELiBJdCBtYXkgcmVx
dWlyZSBzb21lIHdvcmsgaW4gdGhlIFVEQyBjb3JlLiBQZXJoYXBzDQo+ID4gPiA+ID4gPiB3ZSBj
YW4gZmxhZyB3aXRoaW4gZHdjMyBmb3Igbm93IGFuZCBwcmV2ZW50IGFueSBmdXJ0aGVyIG9wZXJh
dGlvbiBmb3IgYQ0KPiA+ID4gPiA+ID4gc2ltcGxlciBmaXguDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiBIaSBUaGluaCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgICBBcmUgeW91IHJlZmVycmlu
ZyB0aGF0IGlmIF9fZHdjM19zZXRfbW9kZSBmYWlsZWQgd2l0aCBjb3JlIHNvZnQgcmVzZXQNCj4g
PiA+ID4gPiB0aW1pbmcgb3V0LCB0aGUgY2FsbGVyIGkuZS4sIGR3YzNfc2V0X21vZGUgd2hvIHF1
ZXVlcyB0aGUgd29yayBuZWVkIHRvIGtub3cNCj4gPiA+ID4gPiB0aGF0IHRoZSBvcGVyYXRpb24g
YWN0dWFsbHkgZmFpbGVkLiBTbyB3ZSBjYW4gYWRkIGEgZmxhZyB0byBpbmRpY2F0ZSB0aGF0DQo+
ID4gPiA+ID4gZ2FkZ2V0IGlzIGRlYWQgYW5kIHRoZSBjYWxsZXIgb2YgZHdjM19zZXRfbW9kZSBj
YW4gY2hlY2sgdGhlIGZsYWcgdG8gc2VlIGlmDQo+ID4gPiA+ID4gdGhlIG9wZXJhdGlvbiBpcyBz
dWNjZXNzZnVsIG9yIG5vdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPciBhbSBJIG1pc3VuZGVy
c3RhbmRpbmcgeW91ciBjb21tZW50ID8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE5v
dCBqdXN0IGluIF9fZHdjM19zZXRfbW9kZSgpLiBJIG1lYW4gYW55IHRpbWUgZHdjM19jb3JlX3Nv
ZnRfcmVzZXQNCj4gPiA+ID4gZmFpbHMsIHRoZW4gd2Ugc2V0IHRoaXMgZmxhZy4gU28gdGhhdCBp
dCBjYW4gcHJldmVudCB0aGUgdXNlciBjYWxsaW5nDQo+ID4gPiA+IGFueSBnYWRnZXQgb3BzIGNh
dXNpbmcgbW9yZSBjcmFzaGVzL2ludmFsaWQgYmVoYXZpb3IuIFRoZQ0KPiA+ID4gPiBkd2MtPnNv
ZnRjb25uZWN0IGlzIGFscmVhZHkgd3Jvbmcgb24gcHVsbHVwKCkgb24gZmFpbHVyZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFNvIHRoYXQgd2UgY2FuIGhhdmUgYSBjaGVjayBpbiBkaWZmZXJlbnQgZ2Fk
Z2V0IG9wcy4gRm9yIHB1bGx1cCgpOg0KPiA+ID4gPiANCj4gPiA+ID4gc3RhdGljIGludCBkd2Mz
X2dhZGdldF9wdWxsdXAoKSB7DQo+ID4gPiA+IAlpZiAoZHdjLT51ZGNfaXNfZGVhZCkgew0KPiA+
ID4gPiAJCWRldl9lcnIoZGV2LCAicmVzZXQgbWUuIHhfeCBcbiIpOw0KPiA+ID4gPiAJCXJldHVy
bjsNCj4gPiA+ID4gCX0NCj4gPiA+ID4gDQo+ID4gPiA+IAlhYmMoKTsNCj4gPiA+ID4gfQ0KPiA+
ID4gPiANCj4gPiA+ID4gUGVyaGFwcyB0aGUgZWZmb3J0IGlzIHByb2JhYmx5IHRoZSBzYW1lIGlm
IHdlIGVuaGFuY2UgdGhlIFVEQyBjb3JlIGZvcg0KPiA+ID4gPiB0aGlzPyBJbiBhbnkgY2FzZSwg
SSdtIGZpbmUgZWl0aGVyIHdheS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4g
VGhpbmgNCj4gPiA+IA0KPiA+ID4gSGkgVGhpbmgsDQo+ID4gPiANCj4gPiA+ICAgU28geW91IGRv
bid0IHdhbnQgVURDIHRvIHJldHJ5IHB1bGx1cCBpZiBpdCBmYWlscyB0aGUgZmlyc3QgdGltZSA/
IEFzIHBlcg0KPiA+ID4gcGF0Y2gtMiBvZiB0aGlzIHNlcmllcywgSSB3YXMgdHJ5aW5nIHRvIHBy
b3BhZ2F0ZSB0aGUgRUlUTUVET1VUIHRvIFVEQyBzbw0KPiA+ID4gdGhhdCB0aGUgY2FsbGVyICht
b3N0IHByb2JhYmx5IGNvbmZpZ2ZzKSBjYW4gdGFrZSBhcHByb3ByaWF0ZSBhY3Rpb24gYXMgdG8N
Cj4gPiA+IHdoZXRoZXIgaXQgbXVzdCByZXRyeSBwdWxsdXAgb3Igbm90Lg0KPiA+ID4gDQo+ID4g
DQo+ID4gTm93IEknbSBjb25mdXNlZC4gSWYgdGhlIHNvZnQtcmVzZXQgdGltZXMgb3V0LCB0aGF0
IG1lYW5zIHRoYXQgdGhlDQo+ID4gc29mdC1yZXNldCAoc2VsZi1jbGVhcmluZykgYml0IGlzbid0
IGNsZWFyZWQuIEhvdyBjYW4gd2UgcmV0cnkgaWYgaXQncw0KPiA+IHN0dWNrIGluIHRoaXMgc3Rh
dGU/IE15IGltcHJlc3Npb24gaXMgdGhhdCBzb2Z0LXJlc2V0IHdvdWxkIG5vdCBjb21wbGV0ZQ0K
PiA+IGF0IGFsbC4gSXMgdGhhdCBub3QgdGhlIGNhc2UgZm9yIHlvdSwgb3IgaXQncyBzaW1wbHkg
YmVjYXVzZSB3ZSBuZWVkIGENCj4gPiBsb25nZXIgc29mdC1yZXNldCB0aW1lb3V0Pw0KPiA+IA0K
PiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiANCj4gSGkgVGhpbmgsDQo+IA0KPiAgIFNvcnJ5IGZv
ciBub3QgYmVpbmcgY2xlYXIuIFRoZSBpbnRlbnRpb24gb2YgcGF0Y2gtMSB3YXMgdG8gZW5zdXJl
IHdlIGRvbid0DQo+IHN0YXJ0IHRoZSBjb250cm9sbGVyIGlmIHJlc2V0IHRpbWVzIG91dCBhbmQg
cGF0Y2gtMiB3YXMgdG8gZW5zdXJlIHRoYXQgVURDDQo+IGlzIGluIHN5bmMgd2l0aCBjb250cm9s
bGVyIGJ5IHVuZGVyc3RhbmRpbmcgdGhhdCBnYWRnZXRfY29ubmVjdCBoYXMgZmFpbGVkDQo+IGFu
ZCBuZWNlc3NhcnkgY2xlYW51cCBoYXMgdG8gYmUgZG9uZSBpbiBnYWRnZXRfYmluZF9kcml2ZXIu
DQoNClRoYXQgc2hvdWxkIHN0aWxsIGJlIHRoZXJlLg0KDQo+IA0KPiBCdXQgdXN1YWxseSBzaW5j
ZSB0aGUgVURDX3N0b3JlIGlzIHRoZSBvbmUgdGhhdCBpcyBjYXVzaW5nIHB1bGx1cCB0byBiZQ0K
PiBjYWxsZWQsIHRoZSBlcnJvciB2YWx1ZSBpcyBwcm9wYWdhdGVkIGJhY2sgdG8gVURDX3N0b3Jl
LiBJZiBpdCBzZWVzIGENCj4gZmFpbHVyZSwgaXQgZG9lcyBhIHJldHJ5IHRvIHB1bGx1cC4NCj4g
DQo+IEkgZGlkbid0IGNoZWNrICB3aGV0aGVyIHN1YnNlcXVlbnQgcmV0cmllcyBieSBVREMgdG8g
cHVsbHVwIGFyZSBoZWxwaW5nDQo+IGNsZWFyIHRoZSByZXNldCBiaXQgb3Igbm90LiBCdXQgSSB0
aG91Z2h0IHJldHJ5aW5nIHB1bGx1cCB3b24ndCBiZSBvZiBhbnkNCj4gaGFybS4NCg0KSXQncyBm
aW5lIHRvIHJldHJ5LiBJJ20gdGhpbmtpbmcgdGhhdCB0aGUgY29udHJvbGxlciBpcyBpbiBhIGJh
ZCBzdGF0ZQ0KYXQgdGhpcyBwb2ludCB0aGF0IHdlIGNhbid0IHJlY292ZXIgKGhvcGVmdWxseSB0
aGF0J3Mgbm90IHRoZSBjYXNlKS4NCg0KPiANCj4gSSBub3cgZ2V0IHRoYXQgbXkgcGF0Y2hlcyBh
cmUgaW5jb21wbGV0ZSB3LnIudCBoYW5kbGluZyB0aGUgdGltZW91dC4NCj4gDQo+IElJUkMgb25l
IG9mIHRoZSBmb2xsb3dpbmcgaXMgd2hhdCB5b3UgYXJlIHN1Z2dlc3Rpbmcgd2UgbmVlZCB0byBk
bzoNCj4gDQo+IE9wdGlvbi0xOg0KPiBTZXQgYSBmbGFnIHdoZW4gcmVzZXQgdGltZXMgb3V0IGFu
ZCBjbGVhciBpdCB1cG9uIGNvcmVfZXhpdCAvIGNvcmVfaW5pdC4gSWYNCj4gdGhlIGZsYWcgaXMg
c2V0LCBibG9jayBjYWxscyB0byBhbGwgdGhlIGdhZGdldF9vcHMgaW4gZHdjMy4gQmFzaWNhbGx5
IGV2ZW4NCj4gaWYgcmV0cnkgaGFwcGVucyBmcm9tIGNvbmZpZ2ZzL1VEQywgd2UgYmFpbCBvdXQg
aW4gcHVsbHVwL3VkY19zdGFydCBldmVuDQo+IHdpdGhvdXQgdHJ5aW5nIHRoZSByZXF1ZXN0ZWQg
Z2FkZ2V0IG9wZXJhdGlvbi4NCj4gDQo+IE9wdGlvbi0yOg0KPiBJZiBnYWRnZXRfY29ubmVjdCBm
YWlscyB3aXRoIC1FVElNRURPVVQgaW4gVURDLCBoYW5kbGUgdGhlIGZhaWx1cmUgYW5kDQo+IGlt
cGxlbWVudCB0aGUgc2FtZSBmbGFnIGluIFVEQyBhbmQgZG9uJ3QgZXZlbiBjYWxsIGFueSBnYWRn
ZXRfb3BzLg0KPiANCg0KSSdtIHRoaW5raW5nIG9mIG9wdGlvbi0xLiBGb3Igb3B0aW9uLTIsIHdl
IGNhbid0IGNvbnRyb2wgaWYgdGhlDQpnYWRnZXRfb3BzIHdpbGwgYmUgY2FsbGVkLiBXZSBvbmx5
IGhhdmUgY29udHJvbCBob3cgd2Ugd2lsbCByZXNwb25kIGluDQpjYXNlIHRoZXkgZ2V0IGNhbGxl
ZCBhZ2Fpbi4NCg0KQnV0IG5vdyBJJ20gdGhpbmtpbmcgYWdhaW4sIEkgdGhpbmsgaXQgbWF5IGJl
IG9rIHdpdGhvdXQgYWRkaW5nIHRoZQ0KZmxhZy4gVGhlIFVEQyBjb3JlIGFuZCBnYWRnZXQgZHJp
dmVyIHdvbid0IGRvIGFueXRoaW5nIGVsc2UgYmVmb3JlDQpwdWxsdXAoMSkgaXMgc3VjY2Vzc2Z1
bC4gQ2FsbGluZyBvdGhlciBnYWRnZXRfb3BzIHNob3VsZCBiZSBoYXJtbGVzcw0KKGllLiBpdCB3
b24ndCBjcmFzaC9icmVhayB0aGUgc3lzdGVtKT8NCg0KU29ycnkgZm9yIHRoZSBub2lzZSwgYnV0
IEkgdGhpbmsgaXQgbWF5IGJlIG9rIHdpdGhvdXQgbWFya2luZyB0aGUNCmNvbnRyb2xsZXIgZGVh
ZC4gSSB3b25kZXIgaWYgd2UgY2FuIGNvbmZpcm0gbXkgc3VzcGljdGlvbiBvbiByZXRyeT8gSQ0K
YmVsaWV2ZSB0aGlzIGlzIG5vdCBlYXN5IHRvIHJlcHJvZHVjZSBvbiB5b3VyIHNldHVwPyBJZiBu
b3QsIEkgdGhpbmsgd2UNCmNhbiB0YWtlIHlvdXIgY2hhbmdlIGFzIGlzLg0KDQpUaGFua3MsDQpU
aGluaA==
