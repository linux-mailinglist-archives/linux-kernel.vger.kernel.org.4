Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91D6887FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBBUH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjBBUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:07:17 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCF7AE4F;
        Thu,  2 Feb 2023 12:07:16 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312J8Utr028316;
        Thu, 2 Feb 2023 12:07:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=EFuaF1nmYFqeRmr/UgoSvfZo3kQVxKuBER72jKPYH/o=;
 b=kaUhEFJmdo4knJFeg88fV2aM+bWE4Ds1f6fCvcWIxtC76P11K3e4edUFD4dBZ06osQwV
 4Uhbw1nvZCeExA35Ws2SRuW9oqZJtzTpMWdAiQK0aFjOzFmnE68bN+OogWjPvyngKOh3
 0rGYkUuNFbbiQawhMm429TSK+CYbCk6zimAJdqJ+cZdWnMWEH3367+TdWGKVXZjG/uUm
 xIqIGZNGytIMtZ+8pjwv+dGujuwnNNguyi0ZR/MIu7DV57T7zve1Q0/UxISjorT0cIpn
 PWUy7SDToCdIZP5cApZVgytUHD9/9jPzVZ6Uc//mZhwtbfrEkNXJ3bQ6R4VRa36cpN1Z Hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nfq4nr36v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 12:07:03 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 03CC5400CE;
        Thu,  2 Feb 2023 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675368423; bh=EFuaF1nmYFqeRmr/UgoSvfZo3kQVxKuBER72jKPYH/o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EymKmNFowCJXpuvZqMyF4ucT3k9qJfK4M8GInXUeuTVeQdqTt7d4RtJXtWl7GAn3a
         N7MtSi7VLD2ry6LscdLqvMpTQAx8FB4kY/vilPnjJT7n+yCbKZkhO+wkIcMXHgtErZ
         I4eJJJS+EOff4Oxgjp6oFoboT98FpGBqe77jiA+twTYsZ3kQC7cdE/AhM+JddFt3ub
         Hdh3347V58AY0yFpsvVeqDyXrxBfU0ZWKD51+EBcmsEctj5un0HBXYzVdfywCj9HnE
         2XLloUaeHlMXZ2hl7NEb90zWRoM6JvR89nEp5IVO5wR9ECyZxXEAB85LQKF3fqeRvC
         b7LTiA3e0DUxQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32AA0A006E;
        Thu,  2 Feb 2023 20:07:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 51043800C4;
        Thu,  2 Feb 2023 20:07:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="s4U9ahoQ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/1XXEK2PCLciWlcT4pILLX5m60jj8ArbxSNvoDCThimRMuWpz8hPHhAVmsNVdw0mbNYcJH7Zj29Xgwo+7xHZyAGbFQS9HoJMU2CxnIn/bXMSpLbxXMAfxgBQzKk8O2kmP1evz15d8g+sLi7w/HlHjxaSertvW0BdCOZaKYcnAL7syDd1rLUeaONDwsk6MUBMZO8N1dM0FkcE+sJOoPe1V4gT4TrCpUfm3uV2QCVuSReeBgn4fiZEYnXSfWQHTH3BYfR/n9Jzf4cYZOpltMipDZ3moFhRynXTLoFBgLfpSWdkn+GmgwXKB+T701tONyNR2nLY7ddSm4CD0z83adzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFuaF1nmYFqeRmr/UgoSvfZo3kQVxKuBER72jKPYH/o=;
 b=lVsv7njh67v8nA/IMXJZ+CdPD2ThVTYYb6zC9TRfYrN0PIxy0+1PzO727Fz1i6N2xCyMKgmFAiCkVysaXtBJ9m8r7vddaJFjskiojfQfDuelq2idBah5v8LmeGoBJoePoVE8Xhmu8j6ht0JXsld4MgaLhIuA2vcOLggUsK+fwBqjQRBCM7md5CHFOm9gxa0h17Lcuq4E0jfj0lfimlYt+2qKcjxIzFmd/NIkoJKITfgLqlDXa2MPuk+Q5sb81+0inNLkrIDfk0Q3F81stxnUAG7YGSV7Tfpmbpn3aq3pNatu/eN1o7xO/jNQlN8ceQscwpVAj7lJkr5xtOEMf+GxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFuaF1nmYFqeRmr/UgoSvfZo3kQVxKuBER72jKPYH/o=;
 b=s4U9ahoQ7vuEZM1Eoq0AU6AyVpRN6LgLM27CLB7OkQTxbQbAfSpNSAVY+WqLc4xqlbpDL/H9NnEts/LIdCLo8ZVI0Jwkr2C4ef4oL81izRsI/5S3KrYGvB43bveHGEjT9N8zphA2y4fn6jZr1yFdh5y/efWbDE8W/3FCTj8S6qM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 20:06:58 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 20:06:56 +0000
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
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rICAAH0sAIAAD+kAgAADfgCAAAI7gIAAShIAgAESQYCAAB19AIAAC5QAgB+064CAAmC+AIAAqGcAgAD9PwA=
Date:   Thu, 2 Feb 2023 20:06:56 +0000
Message-ID: <20230202200650.cqntlk7m2krsafgd@synopsys.com>
References: <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
 <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
 <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
 <20230201185742.lc26zheeuhvfuxet@synopsys.com>
 <4723be6d-a9c5-17f4-f8d4-6ab0e81d866e@quicinc.com>
In-Reply-To: <4723be6d-a9c5-17f4-f8d4-6ab0e81d866e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7808:EE_
x-ms-office365-filtering-correlation-id: fb925550-dcbe-49d2-67ec-08db0559091b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHM8C5dOXM9Y/lh/KY2Z3sQ3pujeJqqcAddSxJ29To/E+hwALpanYyfqv3Q0HqY36k3Pym9wN2UJwixz4oYvZUmHntguuQ4CsyhVQ1I+CQulQ4/SrUKM2AICf2U5hDTyTr/eu/k9tAA2O+DvZoy2t7o/YAYSMLVoEreFZ6Mc5APC+zTHXTNt1Tfkzdmdj6wWi6Xx1w5FjIfsrTB5L1NASWhmHOD+QmPFqiUdwkxlT+wJho7vtyKY46JR6nseNRubveGtzBWyuft2m3r1sNpMie3+hJBwr6A0uU+Zk33l6O69gfsmXk/NF97lYenBiAaK1GSnS8KmaUeh8xJ7rmZzbtEvWfm0RXe9/HsvUnX/1ePIuvWCau0jhEg9YrUhFb4Qnl3A8MYohhT+nIXilC/Nd4FKTB8erEgtAbLX3Gr09LMDZUOrFSIqYT/rYGJD2+O7kjFZ6+XT/B/ZD6G4kAHDu+2kPcRlCADdJp8Vqi+Elrl8LGStK+ZlpzzgqUT8b+/oIFfWktzGeoigwrRkatq+mOLmqxdThXnhNezbn5ad5tLAoBcx+FcrO90CjQR5ybci3vIuhCNv/QDveoSMjrKOSaPkha4TNytjiecfZ7Vf5qKlIJ7IxpdE8kETc9Ae/+UFhoV4Souq4JJcRRix0uzoJLA53uIag7mf2autuFLrkOiWmQV4vuzmdEPIXNdOhNMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(64756008)(66446008)(41300700001)(8676002)(83380400001)(6916009)(4326008)(76116006)(66476007)(66946007)(66556008)(316002)(8936002)(36756003)(186003)(6512007)(2906002)(5660300002)(478600001)(54906003)(71200400001)(53546011)(38100700002)(6506007)(1076003)(122000001)(26005)(6486002)(86362001)(38070700005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJlckZxYzAzT3VnaURCM29namV2clhRTHpCLzFmdlI0c21weGRLQUhuTlF5?=
 =?utf-8?B?bDBXTmVJVDA1ZkRWdnlBT0JUMHM1U1dTaVJLMWRuVUpuU1d0ejkwK1M2c1ZR?=
 =?utf-8?B?VVZ2ZVVORmN5czZ1cng4TVdEV3dLa25OcUd2UTdXeTFDZ29SR0pra2kwb2Nl?=
 =?utf-8?B?MERRQjZYRDZYSTUyM0YzOTdoNGpMS0ExTzAwY0tQMFhPZ1pEa0ViNnlaVlg1?=
 =?utf-8?B?R0tDaWRyOGc3WCtQNE9ramtPZ1ZBdUhWNDdFTG10b1VwbGozc3hzTENaSGhL?=
 =?utf-8?B?VTNSeXpYM0NWWFhNVUpPNmp4MEtQNVBoRDZGdGFiNTljSE01d3oraWVmYXJU?=
 =?utf-8?B?cUllTmdrd2dGMGdqNEdEdWhOeE5JVENPWnJyMkdUU1diekhlZVBFcHpMRGFx?=
 =?utf-8?B?ZlZYTmNBOUJMV0NaRmlVOVJOY2lZTmt3WDJWZzJBNnRoVkVzWFQ2WGl0UDVY?=
 =?utf-8?B?b2JQdXlpQkI3WVFhdC9lam9wV3VJeVZFb3ZiRm5aa2ZEU0d6blNCL2IveDdZ?=
 =?utf-8?B?b1dpSW9KTGpJanRRcFA1SVJwcW5Jam5zcFFSdWU0dG9oL3lad04vTi9DQzBL?=
 =?utf-8?B?Y2JyUWlxOHl6UTlvN3I0MlMwdjRzZkp6RDBrY0QxbzkrdlhObHMrbTBLdlRk?=
 =?utf-8?B?ZFRaa3AzeVBFT0ZQTHFBSGdKWkhYbmREU1FVK1llMmdWSzBJRjFRMktFQkwr?=
 =?utf-8?B?K2kxaVhzNGozS2xJVFhyRFpEMUVNZXJyb2xYUy8rZmJZL0htL1A3WDBjZG1D?=
 =?utf-8?B?aHdRakczaXJmdXljbnlNWkFUSGJSSjZheUZtbGpCMXArTmgxS3BmYVZLUFVR?=
 =?utf-8?B?Q3AzVGNPcS9wTjMzV3BmdG83T0tFTU1ZZ1JJb3FuYUhKY2g1WjlDZ0d6QVpr?=
 =?utf-8?B?cHM2YXhnaHdSMjNVWnJnci9kZE9ueUhPQVhvQW96ZWxFbWkybWhWYXhoU3ND?=
 =?utf-8?B?am1KUk03Z2d0OUxYczVETnk1Tmh2dmcydUZRVkhtUUNRZS9KajF1RTVldVVy?=
 =?utf-8?B?SEZPUU4xa1BReU9mNk9YajVGNVRsbHdleXhzYWt1SnNLY0Y2dWdKTE8xQjVK?=
 =?utf-8?B?WlZ0bkJNZVJMT1VwSm9wQktHdzQrMWgyNXl2d1o5WitUVGwxeFEwb2QyNGtD?=
 =?utf-8?B?Zjh2MGJLRlI2emo1ZlpEbDdpYU51MHo3bUg0NFZ6cTh2MWU5NTYrN0JEaHNa?=
 =?utf-8?B?Nm1OVzlQc3ZMZzgrZ25rMzlJR3lUNnBaR3dnZlErVGt3VC9SaXQ4aDVtVmJS?=
 =?utf-8?B?V0N0KzFQMEwrclEvRVZpZ3VxVk4wSzdyV1B4T1BNNnhJNlZLQ1huTE9zZVY4?=
 =?utf-8?B?TFN5RFE0VVI1TE13VmdpZlFuOW9INkZ2eUxQZC9oZ2hoa1JUZWxLd0xWUXRB?=
 =?utf-8?B?a3pOL1k3Zm5xL1J3bkVwMVZxeVVxQmhnL1l3QXJaL0U5ZVRkbDJDeVVXTThB?=
 =?utf-8?B?QVprQ0NPczBoT3lSRzNUVGxVeFNlVGlCM0U4RTZ1Rnd0T25IWU54MlI4TWpD?=
 =?utf-8?B?VWVUbTNOMmJnOHBlQTE4UUtGVk9FZHNoeEFZQ2dIMjEwSGMvWkhZai93WWdV?=
 =?utf-8?B?ajN4bGIzSHNsQUMwOTFmdWFYbDNDSE4rRDNkTzA4TmtaM0MrYktrZktUclZW?=
 =?utf-8?B?YlZlMVcrL1doNjV0TXNIR0xuOXRueTV6d2xPc29BemF1dHM3MFFmaEUxOGsx?=
 =?utf-8?B?ZkoyZHBjOXpWaXA1cVpQNmxFeGhzYy9NSTV1WDlzcHc1czJENVMxWHhNcHZK?=
 =?utf-8?B?TG9qSU5mTkRxMFlVcUZKb296RGlFWXpXUzVUQnpQV0ROT1Uvc3pYdEQ4L28y?=
 =?utf-8?B?Y0kyS3ZrV3JYOFlIT2ZFTHdNYTJyTjkweTQ3MFdpR2pNQUlCc3d2eXlDWXdp?=
 =?utf-8?B?aFJuNnR6a3p6V2VtdmY3U3U3eTFVYnNRQVQxRGJDZlBmQ2IwTGFZS2FnZWs1?=
 =?utf-8?B?NTZuL1V1SVJ0aTNQQ0N0SFFBSWZMaUgxQTBXdjEwMVFlZG45M3Jud0piRG1t?=
 =?utf-8?B?UENQam1ZR3Z1L3d1djRHMERpdDNYQjZPM1Ird2tpM1V5RDlhMXJHZTdGaEVu?=
 =?utf-8?B?eWIyNUhmUGpwbWs1QzdZcGxBeDRKWU9Xc1pWeDcrSHRuUlpuaDc0SktwUk55?=
 =?utf-8?B?ZDNEeS8zdkJpOW1SNHlrWk8wRmRrYk9OSThtM1FaOFczTDkwYzlRN0VSZVhn?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B94420182070A4E84F78ED0F070E68E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkRUaWhPWnBORFhWM3VZR2V0dkhOUWg2bWNsZkVNOHY0aFQ3QjhqQVF5bVVi?=
 =?utf-8?B?UzFnbnJtN21iUmlWcHlZeVFvdVc5QnZVeXM1elRoVlorOEt6cXpEZUV3RThU?=
 =?utf-8?B?R3BZVnczM2pFRXlIWll3Y1dXVGt4bEFXRzZlTEhaaWtXelJHbC9GcGpLWkZ3?=
 =?utf-8?B?WGp3bGlGaHVhZE5RRDJUNk1GZzQ0cnlOSDUyZHo0RitIS05US2JDTWFLQWhY?=
 =?utf-8?B?b2lnUS9DaitjalBYNzlvN2JZR3oyUHM1QmFLY3lOU2xjb0EwL0pFL0tqZklr?=
 =?utf-8?B?Kyt4YUZGMERDMlNKdm1ZU0NDT0pPYzZTOEx5cFkvTitXU0d5bVVDNGd4SEt3?=
 =?utf-8?B?a2hidkJHcDlKNXlmOFIxQkgwcWlaMTkzZEhpRUxYQTl3OHRXYjdBenBKajhJ?=
 =?utf-8?B?Rm9SUG8wUlFqY25uWXZJRHBoSUNnVWFET0lmZ3hvWFp1Y0pwWFBjK09JZDEy?=
 =?utf-8?B?cmphallXQm1kZXJzcENzRi83VGlsZGJMMkUySW43WUw0dkNyR0FMWmtLaWNC?=
 =?utf-8?B?aDVZNUw1M2Q0Z01vVEcyNzRXb2xlTzl0WVJqZ0dlU0taOTNYQ2NpL2NrZVpC?=
 =?utf-8?B?Q3pJd2ZLM1VsMUJkaFAxY3BQOGw3czhadmZ6R3NaV3U2eE1iUDNvRU1ubzdU?=
 =?utf-8?B?SEtrS2hSS0h6eG4yb0RjdXV3VEk4c0U0VHlvTGF6Tjg1Y2xoQkVqRVppcnY5?=
 =?utf-8?B?NmtxREN0eWRKa09QK3I0Q1hOQms2Ym1jNElKQlkwWlptWkpMdFNGcDFMMEhq?=
 =?utf-8?B?VmQwZVZNVlZWTlVmOUczcEhMRkpnRnVTVnNaRjJkVWZnOGN2b2VLeVF4YVFK?=
 =?utf-8?B?eFgzbVB4RkdveExFTmMvbGo3SUk3eHptZEVSQ3dqNzY3MUh4bWo2VEZJT0Fh?=
 =?utf-8?B?TXA2b2w2QUtqWUhMYlUzeGZRTFhMUjBtV2JRWnA1cy9WSUpJanpwREhBZDJp?=
 =?utf-8?B?WmZtRTI3WFp0cDdoL01FbGpMSnBEalluLzRDQSs2Y0l6aURrcWQ4eVQrYTB6?=
 =?utf-8?B?c1h0aTVhZ1UwVmlDWVhDWSsreGF0ZU9UclVncXVXNVV2T0c4MVBqczJFSFgv?=
 =?utf-8?B?R3lnSVhDbUlnNXN3RzhIRTVlT1NDcjFoTlRqWU9DOThlVHFDR1I2SnFZNHY5?=
 =?utf-8?B?THBLTHRPNUJQL0FEcDJTQVRZRWhQUXZXV2NVd0tkd0owRnhhMzVnOVZhTEE5?=
 =?utf-8?B?cUo4VHpFOEtYZkFBY3pObkFQbll0cGp0dU5BWUdSOGZuYTErTGlIRnNlZjBF?=
 =?utf-8?Q?OFzuMWW5MMlj/b/?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb925550-dcbe-49d2-67ec-08db0559091b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 20:06:56.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 424BdKrLkyIeZ+HF25WzAE08L5q3cPBsMz6Jj4ugXJcmgPazTEsQGuzix+ZWhraroYGQWptj/edd7zoD5ghfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
X-Proofpoint-GUID: xNHSTgKrQxvODKDI7jbPya_cXDxVfq2H
X-Proofpoint-ORIG-GUID: xNHSTgKrQxvODKDI7jbPya_cXDxVfq2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxlogscore=498 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMDIsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IA0KPiBPbiAyLzIvMjAy
MyAyOjU3IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVHVlLCBKYW4gMzEsIDIwMjMs
IExpbnl1IFl1YW4gd3JvdGU6DQo+ID4gPiBoaSBUaGluaCwNCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiByZWdhcmRpbmcgeW91ciBzdWdnZXN0aW9uLCBhc3N1bWUgaXQgaXMgbm90IFBDSWUgdHlwZSzC
oCBzdGlsbCBoYXZlIG9uZQ0KPiA+ID4gcXVlc3Rpb24sDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4g
LcKgwqDCoMKgwqDCoCBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykNCj4gPiA+
ICvCoMKgwqDCoMKgwqAgaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpIHsNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghZXZ0LT5jb3VudCkgew0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiByZWcg
PSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSk7DQo+ID4gPiArDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEocmVn
ICYgRFdDM19HRVZOVFNJWl9JTlRNQVNLKSkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZ0LT5mbGFncyAmPSB+RFdD
M19FVkVOVF9QRU5ESU5HOw0KPiA+ID4gDQo+ID4gPiBkbyB3ZSBuZWVkIHRvIHJldHVybiBJUlFf
V0FLRV9USFJFQUTCoCA/DQo+ID4gTm8sIGlmIGV2dC0+Y291bnQgaXMgMCwgYnV0IEdFVk5UQ09V
TlQgaXMgPiAwLCB0aGUgY29udHJvbGxlciB3aWxsDQo+ID4gZ2VuZXJhdGUgaW50ZXJydXB0LiBU
aGUgZXZ0LT5jb3VudCB3aWxsIGJlIHVwZGF0ZWQgYW5kIHRoZSBldmVudHMgd2lsbA0KPiA+IGJl
IGhhbmRsZWQgb24gdGhlIG5leHQgaW50ZXJydXB0Lg0KPiANCj4gDQo+IHdoZW4gd2lsbCBuZXh0
IGludGVycnVwdCBoYXBwZW4gPw0KDQpJbW1lZGlhdGVseSBhZnRlci4gWW91IGNhbiB0ZXN0IHRo
aXMgYnkganVzdCByZXR1cm4gSVJRX0hBTkRMRUQgYW5kIG5vdA0KY2xlYXIgdGhlIEdFVk5UQ09V
TlQgdG8gc2VlIGl0cyBiZWhhdmlvci4NCg0KPiANCj4gYXMgd2hlbiBlbnRlciBoZXJlLCBpIGd1
ZXNzIEdFVkVOVENPVU5UIGlzIGFscmVhZHkgPiAwLCBidXQgd2UgZGlkbid0IHJlYWQNCj4gaXQu
DQoNCkdFVk5UQ09VTlQgaXMgYWx3YXlzIHVwZGF0aW5nIGFzIG5ldyBldmVudHMgYXJlIGdlbmVy
YXRlZC4gV2Ugb25seSBjbGVhcg0KaG93ZXZlciBtYW55IGV2ZW50cyB3ZSBwcm9jZXNzLCBidXQg
dGhhdCBkb2Vzbid0IHN0b3AgaXQgZnJvbQ0KaW5jcmVtZW50aW5nLg0KDQpCUiwNClRoaW5oDQoN
Cj4gDQo+IA0KPiA+IA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+
ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+
ID4gPiANCj4gPiA+IGFzIGhlcmUgcmV0dXJuIElSUSBIQU5ETEVELCBob3cgY2FuIHdlIG1ha2Ug
c3VyZSBhIG5ldyBJUlEgd2lsbCBiZSBoYW5kbGVkDQo+ID4gPiBhZnRlciBwcmV2aW91cyBJUlEg
dGhyZWFkIGNsZWFuIFBFTkRJTkcgZmxhZyA/DQo+ID4gSWYgZXZ0LT5jb3VudCA+IDAsIHRoYXQg
bWVhbnMgdGhlIGJvdHRvbSBoYWxmIGlzIHN0aWxsIHJ1bm5pbmcuIFNvLA0KPiA+IGxlYXZlIGl0
IGJlLiBJZiBldnQtPmNvdW50ID09IDAsIHRoZW4gdGhlIGNhY2hlZCBldmVudHMgYXJlIHByb2Nl
c3NlZCwNCj4gPiB3ZSdyZSBzYWZlIHRvIGNsZWFyIHRoZSBQRU5ESU5HIGZsYWcuIE5ldyBpbnRl
cnJ1cHQgd2lsbCBiZSBnZW5lcmF0ZWQgaWYNCj4gPiBHRVZOVENPVU5UIGlzID4gMC4NCj4gPiAN
Cj4gPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IGFsc28gZm9yIG5v
bi1QQ0llIGNvbnRyb2xsZXIsIGNvbnNpZGVyIElSUSBtYXNrIHJlZ2lzdGVyIHdvcmtpbmcgY29y
cmVjdGx5LA0KPiA+ID4gDQo+ID4gPiBjb25zaWRlciBhIGNhc2UgSVJRIGhhcHBlbiBiZWZvcmUg
SVJRIHRocmVhZCBleGl0LMKgIGhlcmUganVzdCByZXR1cm4NCj4gPiA+IElSUV9IQU5ETEVELg0K
PiA+ID4gDQo+ID4gPiBvbmNlIElSUSB0aHJlYWQgZXhpdCwgaXQgd2lsbCBjbGVhbiBQRU5ESU5H
IGZsYWcsIHNvIG5leHQgSVJRIGV2ZW50IHdpbGwgcnVuDQo+ID4gPiBub3JtYWxseS4NCj4gPiA+
IA0KPiA+ID4gaWYg7KCV7J6s7ZuIIHNhdyBQRU5ESU5HIGZsYWcgaXMgbm90IGNsZWFyZWQsIGRv
ZXMgaXQgbWVhbiBJUlEgdGhyZWFkIGhhdmUgbm8NCj4gPiA+IGNoYW5jZSB0byBleGl0ID8NCj4g
PiBUaGUgUEVORElORyBmbGFnIHNob3VsZCBiZSBjbGVhcmVkIGV2ZW50dWFsbHkgd2hlbiB0aGUg
Ym90dG9tIGhhbGYNCj4gPiBjb21wbGV0ZXMuIEkgZG9uJ3QgZXhwZWN0IHRoZSBpbnRlcnJ1cHQg
c3Rvcm0gdG8gYmxvY2sgdGhlIElSUSB0aHJlYWQNCj4gPiBmb3JldmVyLCBidXQgSSBjYW4ndCBn
dWFyYW50ZWUgdGhlIGRldmljZSBiZWhhdm9yLiDsoJXsnqztm4ggY2FuIGNvbmZpcm0uDQo+ID4g
VGhpcyBjaGFuZ2Ugc2hvdWxkIHJlc29sdmUgdGhlIGludGVycnVwdCBzdG9ybS4NCj4gPiANCj4g
PiBCUiwNCj4gPiBUaGluaA==
