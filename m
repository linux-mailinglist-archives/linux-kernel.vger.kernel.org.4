Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FE0676309
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAUCU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjAUCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:20:21 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34097CCFB;
        Fri, 20 Jan 2023 18:20:20 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L1gkKf007437;
        Fri, 20 Jan 2023 18:20:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=cEyKU650chB9T1NX1adUwbINQR/4BW0xKx/ibnYWF+8=;
 b=DktAuDuN7qDdTv/r6uTXHBGm8lceQws7fzJ9yHtvshCn18o5cNP2r4VUPOV7q20Vn+i/
 gEnvM//nIAeTVyUFUAmuk6/p0D4N6Fs3NGy8OcDjFUZhPT+eNDP3yTg/sow/f/zY80qj
 sXFdm5S+wJDtw1ahTautOppO9hR2UvQIY4MhRW1+J+R8WrGb1MBhZBWYCDIUHyXCOsAd
 KeyM6SY8iy428naCAIlIPPGcDUZOcGfo4cOtXj/kJOwSPexglGq/MFAAgC1pvDzEKk3S
 Ty6jTiDMYJolh4Mn/IwdW88qS8OR1fExO/AI0wpvUVVRMwIP/3+Z/rHt6h5FIM0zemd6 Rg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3vhbabe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 18:20:07 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 607AB400FB;
        Sat, 21 Jan 2023 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674267607; bh=cEyKU650chB9T1NX1adUwbINQR/4BW0xKx/ibnYWF+8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VqwXdfZr5FujSOQDI7nFeNvZYMPRZMlSmrhJvPP4x3PL6puQCQMbI6805sxAwn195
         cFGmDpfdaFDoSfPK4cXgC8UXpgjt2rutfl13i2+R2aXdsp7nmAhfcVdwJiCNiQLW9X
         /E1MgPeCAZBBuvx6p2lL6Lp6jCT3soc8YUY+h5/DTu0Ji4bpEcqhCCjzb7x6Ot9q9c
         UwqQJnZjivceZVcgHoUOVrxTtG206hpjPoFcul+QsWLYAKXETZQkWPLAEeIL59fvFd
         yMSjlCMC1IXtLxNPPw2n6Df1tkRqD/LKmzsGJXmKlVjcoMvgMi8Nsyohti/eNLRBZX
         O9v4YhOTE/bRg==
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7CF77A00BC;
        Sat, 21 Jan 2023 02:20:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 16A0EA03F0;
        Sat, 21 Jan 2023 02:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRQ4K7Xl9rAlakGyj2T3O8S3F40tdvUBKgssUeC2Rc67BikNGWFdFeVkyjhyns8/vGuSlrNrIY32vyz+VccXoa/60I3zxB/Huxss6XVVK44YPikMkgrc5aoSvjqIN8bEerQOPVadKp9KfaZJlpD2G8ytlu4wtrJ9GMhi1bQueQdMGqlFaSwzEc6rZWl/9br+So8AWIm7+tzYm1TUCyNkEGQGZDjyMlH322jAmt+rBQ7Vt9AnRvFTgnmAAbNcJTO2VCsGt9oT12yOwlcOyMjBCL6uLGV9AgdNd3Z6XXJl014MBzjju3Y8D2wUDBcNDXG5zZukQRpluNzJiU4jlZTFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEyKU650chB9T1NX1adUwbINQR/4BW0xKx/ibnYWF+8=;
 b=L7SdkskOzgrEmTekMMAXrli/wv8JQLJjYn6W6iSU4MSU1V9d/q3ESA/LXdVoKd4Q55T7tB5YTmLrEMOdDh8+grm8vpsxt9qd+3vayO0QRsdqif/9aHP5lipAtpruvu5yOb5hfCbwIXaVpo/2EQzmnjrYuvDJTm9ZDhO1LNCjPbfqHlpRtxsg27V0Bu5xOIPNOGcUD3fS/wDX3dxwsuU75DC4vDFgE4rPAsU0Uu1gW88e7HM/cldcabo/bqb+R1AhyGU0porNTX2+NIfLdtnrirwMy/zNdcmcLYXohVMNt36FBbU5bGaGkejg2YH+Q1V2+8vHbVTjHrqYOIxDReoW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEyKU650chB9T1NX1adUwbINQR/4BW0xKx/ibnYWF+8=;
 b=b37kNpArLt79X6wgwXlnviFtbtfhXqfMBkmseXBK3A9hVkojyWQbOW+D+88XgkjuFo3OkvCh3spnA8AIm2paZr73Ett0Ka4E/XcShPT9HVsaw8yUx6lCo97G/9H3Wo9GegHzvkK7mKY6dEonocgbLJvdaMDYVdv/EvJQ22AkT+Q=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 02:19:58 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 02:19:58 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAMJAICAADTgAIAAA64A
Date:   Sat, 21 Jan 2023 02:19:57 +0000
Message-ID: <20230121021944.woat55q4qgq43ucq@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <20230120225719.3xau7vwlzxrtbnad@synopsys.com>
 <d2f541bd-ced6-d7b9-a2c3-43e78c249643@quicinc.com>
In-Reply-To: <d2f541bd-ced6-d7b9-a2c3-43e78c249643@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|DM4PR12MB6160:EE_
x-ms-office365-filtering-correlation-id: 23bb522f-30c2-4534-610b-08dafb55fdfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwM3r2wkyRlER78Jn8mhpK3KVH5BgKZ55A6wu9yCrIMy4HB1XhX9RsDgSHDjcRZKS90CAaKnAHn1Z4OSs3jHeNeACjrRGZOqTaSgTjfuRZk7/AqDugiMdhfWjpEdb0f1M22Rl3zhqqDlZhRS0GBfnToDL8XPjqzlDxpPlaqFg4fWxJV021zUbyN6PXrUcTrzcjmOqraf0Pu8LFiBNZH0OjawMFgXywllW/wztBdWXD+xrYA1nkler2FwsP8F9o7etH3SUtnvIR8sPOc/tOkHhV8rWN6sJVCeXn+mYbPjyeQ3z0PBnLMcIk+CZEQI+2D8kkknJTrA1mXDjIIjNIhQeybUlw21+Ugq2Sp64tq3/wCMERfGjQUHx3Ee87UjKOQ3fiKLyJ3KjvLr1AhUiE9p0Dn5kVhWDaUZwIREByndO4Oa7lQ3Et3j4GL7W8s1I00bZ4gU/2tQbV9AdIbUoeO88Qn9b2bczDkcrxfO1l52tJCJMvjRDm8r5oPJqFCz4WYUtRXSTenWRoBC75CwbMbUbulz+qAyCWWGrAVBOYgRP9HFahwCSLXSZUtDVzyMNQFVEDFc/KeBVZrrsqH7JQk3eHxQaTxz3H+L1DBdP7QkPfaBNfZoX5XiN6T8nALmBdQNaQffGM6m51S6q3VPNmAUmYzPM83cIbXQkuN4kbk4ajsiNt53oJa94Xzmv1Jpom/cOGNDHbq1nKJa/r/g1xNCHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(66446008)(6506007)(478600001)(54906003)(53546011)(71200400001)(6486002)(66556008)(6916009)(66476007)(64756008)(66946007)(186003)(5660300002)(316002)(26005)(6512007)(4326008)(7416002)(41300700001)(36756003)(1076003)(76116006)(2616005)(8936002)(91956017)(83380400001)(2906002)(86362001)(122000001)(8676002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2Z3dVRyRXdkblRhMDFva0N1N0svUks4Y0tJV3hOcEpGcHpOY1IvSWU0N2xS?=
 =?utf-8?B?ayttRHhvTTk4Q2orUWFWRWhhVW1vM2lvbWZ4VTVPNmNVcFV6Y0lBUVEyV0Vh?=
 =?utf-8?B?WU9Lemo4dnlveS9mQlY4THZxWVo5aDNZSGpuL2xrRG5iVDlmdTRYTFBqM0Rh?=
 =?utf-8?B?d2J2Q05NS2pyWkJnZmRIaFBvbjJBVGJOS0FVMi9adkgvRldkcUNjZlRNYzRu?=
 =?utf-8?B?OEYwYzdvbG5Sa25lYm81elozWEJ0V0VJbzZxQVN1M3lnMFh1cWZKSUR5a0Rs?=
 =?utf-8?B?a2Y1UVM4aFkvRFAwRm1Wckx6eStFVHRBOHpCdXlOWGEvMEJCejI2aHFhSDNY?=
 =?utf-8?B?WDFyaWNZeHhpS1U4dnpGbnU0cG9aVFc0YlB1ZFJTNGVFQ1FGcU1jOExKTHJB?=
 =?utf-8?B?ZjJNb3U4bE1jejhaVytDNTlKd0VrUlZBSzZuYmlObS9NOGp1U2themc1cVd4?=
 =?utf-8?B?N20rM1dndWZVckNOYVpNZ0dsWFNFRm8xMXdIekVTYXM4N2pEemVtYlNpaVJS?=
 =?utf-8?B?N0R2c1ZrWEFwcmpnQld2ZWJQYjMzcmtLYmtIVnJhZE5NS2I5TmdMYVFwOFJn?=
 =?utf-8?B?cTExZ1hobjlGZGRTTDUyc2JlZXl5Y1Ixb2JxZ1pISzYya0JCVUFESnZSdWhs?=
 =?utf-8?B?a1ZGUTBzamtXTUtYMVFtazArZ1lxc2hqVmpzNEJLa0RlejBmZ2NwT2pMTWta?=
 =?utf-8?B?dzh2ZlNZOGl6TmNRZ0JrRDVlNGtrUCszbjkzWG5PVCtLY1RpU1FWSVVBYUNw?=
 =?utf-8?B?c28vTEI3eDhPWkNjNU40M3RWdzFxdXZQY3ZvVW0zUnBFbFRrRmVsaVFTYTht?=
 =?utf-8?B?a2x5dEdDeUtFblNZcWtoL2ZtdjJJUTRZZlErVERCUmowaUpGaXdscEg3OEpF?=
 =?utf-8?B?Y05GUVRpbWdOWEdrSHBzS21TS0o0TDYwRnJpYnhxZWFNUENXS1VOZlhoWXRE?=
 =?utf-8?B?U21tUTZUYlZuazI0QkhGR2RsbXhHT1BaWFRKMFZkTnNpNlByNVRYMjVkejlv?=
 =?utf-8?B?RDhnVEk5M0tGSVdDcHo2b0FLNXJWYmRXM2JEc3JWb3RDWDZMc0FSSGFLQ3F4?=
 =?utf-8?B?UGlCSjBuUkhBZEpxZTVRazU2UEgrQkQ1ZVQyVk1yU0U1aDlkNlZmNUlqdmZo?=
 =?utf-8?B?a1BGcmNJcjY2SXJaRlN6WS9CV3RSU1Zna1NuSXRndjlrUjQrTFZIY1lGamJ6?=
 =?utf-8?B?QTFuQUQ5d2xYSUdjY3UwUUpJUW1KZzZzK1pLR0JoYkZ3SzdibFJuUk5jRUlL?=
 =?utf-8?B?d25OclVkMWhFSTFoWnBuOEp4MWtva1htM1d3NSttVkZsT0hTMzMrZUtjVXgw?=
 =?utf-8?B?KytVS2Z0K09BdWsvanJGSXhkcUYxYjZzenY0WkxmNFZOZVZtOWdRVWg0VHBF?=
 =?utf-8?B?a0JNcVhrdlhweXNrV09nQUg5d0tGTmsrNkFlZk5qa3F0WlovS1dyOUQyd2xw?=
 =?utf-8?B?MHlMa2VQMXhDV0RnWVJwZGdpVVJvcENYYjZDOVNGcGpZR2pnSnczY05peTUx?=
 =?utf-8?B?TjY4ejQvcnUrcVpLdXBPQkRVSHV0dlBBZksrUW9kYVJWY1VlakxEUDdQcGxZ?=
 =?utf-8?B?N3F0dEZNYzNTSGdBSm5qRnppa1ZIaUdLUHdmeUZKdGg1eTVOODIyclhFZUpE?=
 =?utf-8?B?VGg3NXpPOHhHaitaQVVjWkxaZUVXdkpRbDBRZHl4UTJpaG42UWd5UHl6QzJP?=
 =?utf-8?B?dmw4Wm55bEtXZklqVElidURhM0NlYkovRFBHQzBWamRMU3RiK0pZT3YzSFd1?=
 =?utf-8?B?ZTdHLzRYUWg5S2Y4SjFDVGNWQzJKQU1HS0RCM09vT2YzS0YvSzhyM0kwYklx?=
 =?utf-8?B?amFsajVWNktURmRrbi9sZlMvayt6KzVWZlI4NFJ5WEEwNW5rUERqVjJyTGN4?=
 =?utf-8?B?eDZWSE14ZkpjMldmREx0ZjNrSVVBaDBBT292bUJzNzM5TmxweHF3b0FYSjE5?=
 =?utf-8?B?dUc4NHdObDFSdVRFNEVpVGoybDJlYUZqa2R4ZWgrQzdDSGp2WjJSR0ZqRGtT?=
 =?utf-8?B?SWhlTnVXUDNBc3hGOVhuWW1LV095VXpNYWNVSytYZG5OMEhuaEgva3VIMWVw?=
 =?utf-8?B?Ly9tY3dUL2ZIZjU1bXpheU1LeDlsSEl1Ym14UU1kWlNDaTJja05rM3F2S3h1?=
 =?utf-8?B?SC9JRE9EQ0swYjhZZUhXeHk4d0FsMUVBYVhTNFRsTGM4NmxtUHhaNVJCOGRW?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C81B5FE55D246C49839C394B635629BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NnJHcW9aUGdsSGJPVnAyVGQ5TmhCY2Rjam9nemtYblp1c1JDV3JSZEpEVFFV?=
 =?utf-8?B?K3dnMWNyTXdUbTNVZ0FxUjMyWjMrY29wdzRDOGdjMmltNUc5STBpR1NxRFpY?=
 =?utf-8?B?QXF0aVYrbDFjNitzR0FMS2oxdWt4c3FiajR5VXdiUTBZRVlHZnYvdUtTVzYy?=
 =?utf-8?B?d1BsYzV3bFJhK0QyTWJDTWZibDZUbmxSdVI2UDZBSXRaQ0x3UkpvMVZaRVZx?=
 =?utf-8?B?SWZzcWl4ZWZrRFZjeW44OVFkZk1OaExCZWQ4RTRwYnJpUGNwYmFrTCs2KzJu?=
 =?utf-8?B?VzJKV2t0dElCY0VXTTdTUGU5OWJoN0ZUQ1owdHpxOHdPbjdrZG0vV1lja3FE?=
 =?utf-8?B?V3BZaW42SGx4U1dSTlZkZ0JxSEVDOU41aGpLdnJObnd6azJiQ25pVUR1bUh6?=
 =?utf-8?B?RW4rdzRzRmdMbzZIR2VkQTR6SzcycC9ncmRNU3RnTGVYSDJPemFYZURXTU5o?=
 =?utf-8?B?bXFOOCsweHpJUlpFTVpsOGRZdXN0ZVB4UjZYTEVpNHZmS0dobkNySGdtYUtI?=
 =?utf-8?B?QkkyNVVyL2RkRHJqbmFjMkFTTVVieGxRekwxR2VaV2UxUXROYlc1aGxDYzRQ?=
 =?utf-8?B?SzRGZzN1ckhVLzYvQldWVEVqcGVLRVBaY2RnYWNaWlYwWTZIcWkvalR6anUw?=
 =?utf-8?B?SUxwa1VNazE0dlZ3U0xhaTgvWnVHUWcreHFiT3k0RUMraHE0bURYR2g5OEQ3?=
 =?utf-8?B?V3kyc212Nkc0WFRXSXhraWJIOFhqSEtOQ3lycHJnUy8rckZsKytMVXY1enlj?=
 =?utf-8?B?K3Z5aWpQMDNlNVNyVUxjdEptUGZvTjdra2p5VGlMUlcxdCs3Nld0SWhkTkJh?=
 =?utf-8?B?b09IQjdadERYYk5BWmt0U2FSR3pXVzJQU3ZyaGhJck1EaU1GTy9YTWdQUTRZ?=
 =?utf-8?B?OGdkU0kvbXpPOW1zUlRUUVRHRVp5eTBCNkJwRFlTZ3h4ZG5ZS0xTTjJ2UmJ1?=
 =?utf-8?B?MzREYjdudFRTU2djY1gyNTgwLzRzZTRQNzI4L3ZRWTYwRXhja0VNdmFaS1gv?=
 =?utf-8?B?aFE5WTRhT2ZzcXU0TW1ZcXRsUm5rVXp2a1ZGOEN1VWJvdXN3UzFackQ2SmEz?=
 =?utf-8?B?d3BSVVR0SVNidHRMWUNrTzRyMENmck5qV2o3S2FwL2JPMlA3T0tjR3NaTUQy?=
 =?utf-8?B?MEZSMEdMckE4aTZYS0UxNHVBSitzSXVxUmJmcVpXNVZOZmVkOHhPVC8vSzls?=
 =?utf-8?B?RUZITVBCOTIyWitjeEZGdElQTXNFMmt4R3U4akJVVkJlNmV2dFYxTkg5TlRT?=
 =?utf-8?B?OGVpL3JYL0J2eWFRSDhtTnJyYTYvUzRxVktXa1N4UnJnaVlSWm1adzJFTG54?=
 =?utf-8?Q?gg4ejCRFBmC54=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bb522f-30c2-4534-610b-08dafb55fdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 02:19:57.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGKbRSrulkphhCdxXbCTzy+e+wi+msvT4RKLABlNBm6E/JvgBzRsWtB0PvJi1YHcGHF2kyrn8E4uR5uoBNh6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
X-Proofpoint-ORIG-GUID: DqiHAD-TEbrnxQl0ccV4vVAaBkB90hhn
X-Proofpoint-GUID: DqiHAD-TEbrnxQl0ccV4vVAaBkB90hhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=956 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301210020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKYW4gMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMS8yMS8yMDIzIDQ6MjcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBU
aHUsIEphbiAxOSwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiAN
Cj4gPiA+IE9uIFN1biwgSmFuIDE1LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+
ID4gPiBDdXJyZW50bHkgdGhlIERXQzMgZHJpdmVyIHN1cHBvcnRzIG9ubHkgc2luZ2xlIHBvcnQg
Y29udHJvbGxlcg0KPiA+ID4gPiB3aGljaCByZXF1aXJlcyBhdCBtb3N0IG9uZSBIUyBhbmQgb25l
IFNTIFBIWS4NCj4gPiA+IA0KPiA+ID4gQWRkIG5vdGUgaGVyZSB0aGF0IG11bHRpLXBvcnQgaXMg
Zm9yIGhvc3QgbW9kZSBmb3IgY2xhcml0eS4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQnV0
IHRoZSBEV0MzIFVTQiBjb250cm9sbGVyIGNhbiBiZSBjb25uZWN0ZWQgdG8gbXVsdGlwbGUgcG9y
dHMgYW5kDQo+ID4gPiA+IGVhY2ggcG9ydCBjYW4gaGF2ZSB0aGVpciBvd24gUEhZcy4gRWFjaCBw
b3J0IG9mIHRoZSBtdWx0aXBvcnQNCj4gPiA+ID4gY29udHJvbGxlciBjYW4gZWl0aGVyIGJlIEhT
K1NTIGNhcGFibGUgb3IgSFMgb25seSBjYXBhYmxlDQo+ID4gPiA+IFByb3BlciBxdWFudGlmaWNh
dGlvbiBvZiB0aGVtIGlzIHJlcXVpcmVkIHRvIG1vZGlmeSBHVVNCMlBIWUNGRw0KPiA+ID4gPiBh
bmQgR1VTQjNQSVBFQ1RMIHJlZ2lzdGVycyBhcHByb3ByaWF0ZWx5Lg0KPiA+ID4gPiANCj4gPiA+
ID4gQWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZywgb2J0YWluaW5nIGFuZCBjb25maWd1cmluZyBw
aHkncyBzdXBwb3J0ZWQNCj4gPiA+ID4gYnkgYSBtdWx0aXBvcnQgY29udHJvbGxlciBhbmQgbGlt
aXQgdGhlIG1heCBudW1iZXIgb2YgcG9ydHMNCj4gPiA+ID4gc3VwcG9ydGVkIHRvIDQuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYXJzaCBBZ2Fyd2FsIDxxdWljX2hhcnNocUBx
dWljaW5jLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVp
Y19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgfCAzMDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDE1ICstDQo+ID4gPiA+
ICAgZHJpdmVycy91c2IvZHdjMy9kcmQuYyAgfCAgMTQgKy0NCj4gPiA+ID4gICAzIGZpbGVzIGNo
YW5nZWQsIDI0NCBpbnNlcnRpb25zKCspLCA4OSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ID4gPiA+IGluZGV4IDQ3NmI2MzYxODUxMS4uN2UwYTlhNTk4ZGZkIDEwMDY0
NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiBAQCAtMTIwLDcgKzEyMCw3IEBAIHN0YXRp
YyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiA+
ICAgew0KPiA+ID4gPiAgIAlzdHJ1Y3QgZHdjMyAqZHdjID0gd29ya190b19kd2Mod29yayk7DQo+
ID4gPiA+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+IC0JaW50IHJldDsNCj4gPiA+
ID4gKwlpbnQgcmV0LCBpOw0KPiA+ID4gDQo+ID4gPiBDYW4gd2UgZGVjbGFyZSB2YXJpYWJsZXMg
aW4gc2VwYXJhdGUgbGluZXMgaGVyZSBhbmQgb3RoZXIgcGxhY2VzLg0KPiA+ID4gDQo+ID4gPiA+
ICAgCXUzMiByZWc7DQo+ID4gPiA+ICAgCXUzMiBkZXNpcmVkX2RyX3JvbGU7DQo+ID4gPiA+IEBA
IC0yMDAsOCArMjAwLDEwIEBAIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+ID4gPiA+ICAgCQl9IGVsc2Ugew0KPiA+ID4gPiAgIAkJCWlmIChk
d2MtPnVzYjJfcGh5KQ0KPiA+ID4gPiAgIAkJCQlvdGdfc2V0X3ZidXMoZHdjLT51c2IyX3BoeS0+
b3RnLCB0cnVlKTsNCj4gPiA+ID4gLQkJCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19w
aHksIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+ID4gLQkJCXBoeV9zZXRfbW9kZShkd2MtPnVz
YjNfZ2VuZXJpY19waHksIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+ID4gKwkJCWZvciAoaSA9
IDA7IGkgPCBkd2MtPm51bV9wb3J0czsgaSsrKSB7DQo+ID4gDQo+ID4gQlRXLCBpcyBudW1fcG9y
dHMgdGhlIHRvdGFsIG9mIHVzYjIgKyB1c2IzIHBvcnRzPw0KPiBIaSBUaGluaCwNCj4gDQo+ICAg
Tm8sIG51bV9wb3J0cyBpcyBqdXN0IHRoZSB0b3RhbCBudW1iZXIgb2YgaHcgdXNiIHBvcnRzIHBy
ZXNlbnQgKHByZXN1bWluZw0KPiBlYWNoIHBvcnQgaXMgaHMgY2FwYWJsZSwgdGhpcyBpcyBqdXN0
IHRoZSBudW1iZXIgb2YgSFMgUGh5J3MgYXZhaWxhYmxlKS4NCj4gDQoNCkkgc2VlLCB0aGFua3Mu
IENhbiB5b3UgYWxzbyBtYWtlIHRoaXMgY2xlYXIgaW4gaXRzIGRlc2NyaXB0aW9uLiBJIGdvdA0K
bWl4ZWQgdXAgYXQgc29tZSBwb2ludCBmb3IgdGhlIGVxdWl2YWxlbnQgb2YgSENQQVJBTVMxLk1B
WFBPUlRTLg0KDQpUaGFua3MsDQpUaGluaA==
