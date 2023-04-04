Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0C6D6F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjDDVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjDDVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:44:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6410CA;
        Tue,  4 Apr 2023 14:44:18 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334LZXfh000863;
        Tue, 4 Apr 2023 14:43:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=f0OMpwDqwmKu9+Pop00I3wuC67tAcDSQqtX2vtpIj3s=;
 b=UaTsV6licKRx/p5A1v81eBNo8MXoOGFrlSNWUvh2Hi17MRD1l9g5Ir1P9pDxSS0k+ri+
 t0jCpJK+zaldIgsATu5nQsBoZchqc7wsyQlEf5Wet2wGnX1tHJcwJjz/xvftqzIaOHN5
 YUc+cRjTEKJ7tSPEHOIcI5CG2uNHnVsP0sj+qeUrBAu7tzf3ehhadGSZE5mmzXcqLsmO
 yJFS2hePiWBbM0ou9qS0WomYUns9tC5+jHopTLobycBOccYz/Vk3chNpIVYzkBMlXov1
 /R/MTWoC1kU5EPiT2f7ULsSDALgzLC2xg6pmYxpgBziWjV9aMPTuql12WVVvaaX5zI8j xw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv908bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 14:43:56 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CEF2F40099;
        Tue,  4 Apr 2023 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680644636; bh=f0OMpwDqwmKu9+Pop00I3wuC67tAcDSQqtX2vtpIj3s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BRz7IklFeVxneecFR8YWblQso5jiTncPFM4PDpZrmMoioYzm0Aqzz8H7wUjLxhO4z
         xwPFcO5W0SGkU32zSAI3R+DuMhTEZrM/18OMOaPcV2ngvf+Hfrd3l0/CpzIbn6z9lc
         iFuAnBJgslnqWmcMJSl0FtxpJuTBZb6TN3wbLc8TzoZwQT7ebfZ3WVyXGZ0KPFZVn2
         Rv93bHBgPoZVFsCpB8X7fMLzWr+n7W1W67KpCRdQpAUP+vXu0dWps2x5uZlVTlvWiO
         wBVaVP8Z1vCE8OrisciTjzEWyPp6vOVy8rvhJ58KOqfpBzVmW0HDzY/O2VsO86cAFx
         hP3htcieuhXOA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BCD65A0073;
        Tue,  4 Apr 2023 21:43:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 84B0A800DF;
        Tue,  4 Apr 2023 21:43:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qU0/Gjf8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM8HAeCLMv7u/sa8eCXURLhwRacdCbFM9dAVJ5DtVZxt2YFWphx0AVLEESJ1gC9VQ0oy2He1Y+x1mrhj5jwqN8jhOp4Be1lsPJVnR1NcQMtBWrNhnUq1NOzaGerGhxPjjPHsA5CcrnsXBboXQ0MYXrrC9kfa+5wEyEsCvyvAw8li2oewZ4WzEnPMh/dHObzHDvgzYAfVKLgpOiKPvrJ3RG8I2Zr1XC8Zzx/A31po6d3HsdD32XeQoAQHjW+jMouEFxMVW4IpnncHL3RWPNsNSjTSxkSMYClmAhKKRfW1CNx7QnrOoSgwPdxtEiGgu6e3ehGb4GzkQiSBcl9AkzhmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0OMpwDqwmKu9+Pop00I3wuC67tAcDSQqtX2vtpIj3s=;
 b=YCNsgjpn3SGdWSMY/tvOLjG7K+njZAwxHbHwaiWihkrqIKBtl43GW1mXqOBNnA166jbYaZbOV1zEJqjiLIHnyeVCd/WjrjrCmp0/0JI1+a4wh1eH1mvXY1NkTi96NosnO8xyknJUDHNgshMpbO7ujJj2Zf6tTW7XeQYsN32KrDO/fPCcSZ2uln6dx/y2daWZn0fS7QN13BFfFZVGlHf42CiG7CciT+TwIkp/0W7Sf6LhxBO2gdIDOwenRcEy4RoE+NI4EtVhgukRra+raqABLTkBOYID3y7YUQsPtnwORd+eBtYEenyBItQv+/HAyNmuiw6YllUslPuf+ZTbehrY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0OMpwDqwmKu9+Pop00I3wuC67tAcDSQqtX2vtpIj3s=;
 b=qU0/Gjf8lAY74SXih4kBkzVmATG3M2V7I4bjWb1DJlya7FJ0nUvWHA3363tAc+tHE1fLsVGSUWYuOetJ9DswVMzJMxsTde/zzSMQhz9G6+Cye/oruXAWzEjybYY7C+MLMUWoJ/aTdhx3odAlitmMJy55I3WlhQiO87jBAIkuv7A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 21:43:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 21:43:50 +0000
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
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68QszUAgAB5QYCAAUhdgIABGcUAgAa8LoCAAFDhAIABHkyA
Date:   Tue, 4 Apr 2023 21:43:49 +0000
Message-ID: <20230404214347.mi6rmksr7pym74rp@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
 <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
 <20230403234937.sotn3pznu4winlkw@synopsys.com>
 <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
In-Reply-To: <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ2PR12MB7798:EE_
x-ms-office365-filtering-correlation-id: dbc04f9e-9515-4012-e0da-08db3555ad69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98cKuW/4cUbHnKxk7qwzRTo14eDTqMs+rT5Jm4I7ofcnoH5dIWvWr6i8niFvy6l1KcDpebRPNhMktBRpvL8tbTBiFVtM96Yi8U7Xd/LOyh36x1btQw9mTTteYY7RLYUiRYfKIIQhBMyIWl7qdK1cHF/6jRsmz9PWoT8UbMEXNymG5Pg1syeHAcrydXBZAgPvQiFHpWhYxyB0LZHqLjDNSQmEIQqat4gT0OKUikJg9R6LUu4mk/pxkNQXIhgFhjDeMA6pvvCJksPQ3ytCTfoAss5jhL9FtDzScnEcqaXc9b/exAtSpGfWWAILkmV7Ny9WiuP2gbrP+GAInu7BYl9981UsFGI9jW33p3Rgrd+Sd2nQzPv6qsJzxcVLrXsfK2PzacNaCn4XUxJjHX1k+LjEWldqA8/XoRn8CenL8DNR0ID9f+zVBEfgMyrLy2Dzjt2uJYMcfDsO1b0TkFHJ4AMFQwg8Uto3l/BX7lhRPE5wznIe1ZnrpUcdIFb2BISlUWkMQ0TYUHfKddAkfZbiRS1Xmehta9xq268iwP8YY+BYtVQjn+dQ88wUp0yWu/Ty52oVAcaR4m6V43GGaTtvTPNh26vYVN/IqjUsl+ctGZ+WNwGD86Qhv8Dvs23uoMDqTXdx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(86362001)(71200400001)(6486002)(83380400001)(36756003)(2616005)(38100700002)(38070700005)(122000001)(6512007)(26005)(6506007)(1076003)(53546011)(186003)(64756008)(6916009)(66446008)(8676002)(66476007)(66946007)(66556008)(2906002)(316002)(4326008)(54906003)(41300700001)(8936002)(5660300002)(7416002)(76116006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTl4RHdTUmJoamhCVUVqQm8rMllYejlLKysxOTZYaUhaNGRBb2ZzRjR0aXhq?=
 =?utf-8?B?M2sydkpFcmhZTERtYVg3MDdja3ZrM1kyMi9McnpyQkM1VWRIM0NIaVJhanl6?=
 =?utf-8?B?M1NFbXhIdU1JcFUzMXRDNUtLNkMzWkFkS1lUeHBBUkRiUUhaQitvZFBpeUdm?=
 =?utf-8?B?c2xLNEZuVjRUaFJkK3FXYXBTL3dXT2tmcm54aHorbzVpUTVjSjBGUkhLLzd2?=
 =?utf-8?B?bWw3OXJ2bDN6Y3NSN0lVdk5xT3U1ekMwUXJMWE5MazJlamtKNkpkVEZMTEl6?=
 =?utf-8?B?UkJUNnFXSTRpVWRIUmdOTmEzT3Z0eVNNb2xsL2dVU3owak1HcERpRTBZam02?=
 =?utf-8?B?RjZYdHltWjhCb3A3N0c3RWx3c2hKNXg2dkZQNXJrK3VOTGhCQVJBeDlCRWhF?=
 =?utf-8?B?bEE2TUJKNUdaaVFRWFRCOUh6RmEzREJCdTg1dGRWWHpGcUxtczFiQVR0cG15?=
 =?utf-8?B?NllNbjA5cnpoZWYvTGcwRU1kbFRRUGVjQ1JJU1R3NEt6UnJSQjNPeEJvOU1Q?=
 =?utf-8?B?SUVQUWV2NklxSUxHWGZBY3Q2UkhaaXdjWWNUNGJNcVA5cnYwWmlIV21VaXIr?=
 =?utf-8?B?YzAxNHA5MXdNTlBHMFFDLys1TkFvTmZReUtpVVRZQ1FSaWRBWHNDcW1VUmI0?=
 =?utf-8?B?clpnZ3lmaE1rWHhtWHJEbHc0L2Mxd2tDbnVaM1ZSTzhLNS9rNk9xQU9HcERl?=
 =?utf-8?B?K2YvV2NHZVhybHJLOFVGUmJ0UjRHNWpEZHhRUzJya01SZGg1M3JuZlFGYmtV?=
 =?utf-8?B?TXFZdGkvWmppUFpVcFA0NWkxWjRVU3p4YmRCUlQyZ1lGbGZRREVrVlBsYU9l?=
 =?utf-8?B?Z2ExU3UrUUFUNmZZT3Z5b3d0S1lwTTV2cEZ6aVBaT1JDYldFM1JNM1JlU21l?=
 =?utf-8?B?cW9lNDlueVZZWmNrd0c0MWJxY1A2YUdQdGNGRVpCZlpzZEpiYlRYdnlTd0dv?=
 =?utf-8?B?bk9MV2dxaXdGUTd5VmhGdURMbzNoN2FCNVZKcHRoNWZtMHZCaTNhK0JSUFFX?=
 =?utf-8?B?MUs5emtBSkJUeVRqNnhNeWl0Z0ZIK1drOEFyNmgvc1JIbTgraWEzYmZKTENZ?=
 =?utf-8?B?S08vNEprR3VaTFlCVW1Xb1ozbzFHOWl6alVTRm1ISU5LdmNjRHYzT1ZHTlNG?=
 =?utf-8?B?aGVOc1FIZlJUdnovVHNEcjF4RjlWMTdvUFZGUDkrTVJsd01WWExBVW1VRzhT?=
 =?utf-8?B?ODVXelNWYWp6b0JUK2lLL2pNbGpDWXZJWHhqL2xNc1plQlZscjZOVTR4L1Fk?=
 =?utf-8?B?aGk4b01WNmw1SDRJOVhkK0pHaDFkaEk1VjBvK1IrZG5ycFZpY0N3Y0JROHlO?=
 =?utf-8?B?aC9wTWhTaWlrdHgxWmZyRUlqUnhhMmZNZmwrcUJTTDFxejc2OEh3MzRsaEQ3?=
 =?utf-8?B?MkErL1NKYytYWkdiS3Q4R05DRGU0YzNUVFdIVTNiRnFIOUtoeXZtWC9WK1FL?=
 =?utf-8?B?WitiREgrcFJZR3MxVG9QQ1AvSHhhQkpRRHN4WUFjSkdVQys4VFlZQlBySzRw?=
 =?utf-8?B?dzcyOExIOGYyanNjMTZqeS8yTkxwQzlHVEloWm1GeXZOMHhRUytWNVdWTXlz?=
 =?utf-8?B?UHlSL3JxVXh6WHBISWk3V2w3ODBsWThDNVBCYnZWNUpKVXhGSDBWTGtxaEpZ?=
 =?utf-8?B?V2c0dG5GNVArSUREQVNFMjhxQ1dYYXhnSUw4RGVMSGsxZHZZeE5IMkl4cElu?=
 =?utf-8?B?ZENqckNGWmdtK2w0QlpKTUlic0x5bzJGRkpVOXBwQk5EWmVvUW54V21OVEI3?=
 =?utf-8?B?RDJUelFraVk2U3Y3RmhLSW9BTWFyekoya1o3bW9zdUtJUEpCbXBJek5MSW5h?=
 =?utf-8?B?SFhLWkpad3hSa3YxODFNOGR0WFoyN2Z4N1Z0Zlh0TVNyZjdTQXRqS01UUndL?=
 =?utf-8?B?dm85ZjlCaGtEME50ZUROKzFuWUl3Zm9IR1BMOFVsSlpneEhHN2RHZDlLVXJP?=
 =?utf-8?B?Rm1WN0FZeDNhUEwrVC9HMXM4UzQ2cFVGUkFmWmwzOXpHU2VDWXpwUUgxRE0r?=
 =?utf-8?B?WVBOZVlpS1lFYTBhOC94KzZydTRjZXVRQzRPaDZpUnRydGJCK3BndDkxRUVr?=
 =?utf-8?B?R0lxZmNaV2xOWFBFQklSendmaEVjdnhzYUE2R3paNlUzTE44WE1sMjczdmNB?=
 =?utf-8?B?WjJydE5ZZStqVURNOHFkbStsanhQZzdwa0R1bWMxVU5Wdi96SDdHQ1NZbVND?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1823638D49A644FAE5C151E217713FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VXA1TTNLSzFrNjlXZWFPMk5nVVRDb1J6d01BT2JpZGUyRU9nM1pYclNCMnYz?=
 =?utf-8?B?WTVIS3g0cjIydHZqaVJyWCsxNEhFNzViTjdDTGtSV1ZZUnFWVm5iaHdaWHVw?=
 =?utf-8?B?OXMwYUYzREgxZTl1VlRYaE9CWVBBbnZERHdmclNqV0o5NHpERjhlaThNMmFM?=
 =?utf-8?B?SlJwNm96b2xZL2loRnF1elNWS1ZaSmdxenFpZGZvYllYSWp5OTJSTUdJYWRV?=
 =?utf-8?B?azFpR2g1bWRPbVVLazRZTytrUzFZeGhRMTlXS0xzQXkwdFJWbVR0UWM4Rkts?=
 =?utf-8?B?NHNPalluK3ZmclFMYjZwa1VuN1Ryb0FtYzlLVWlUQS83UU5KdnplaVNmc25y?=
 =?utf-8?B?TTVtdkUyNEZvZno0d1VvWnl2cVQwZmpkUlZ4OWcwbkpTS1NheVZXSU05Y3lC?=
 =?utf-8?B?VUdUa285eHZWSlpoV3lkZGJVcWxZcnErZEU0dlZBYnlxN2RYNkwvZ0N3K2kr?=
 =?utf-8?B?NTI5dndpeHV1VmcvWFkyWFpwYWlTbXEwdGhRUGxOS0xVempxbTRtSUFHdTgw?=
 =?utf-8?B?dlZjaGMvcHAxNGxpZ2Q0Z0dWWEVhWVFmSy85bWxqcUtiT2NTd3ZHRzFQYTBO?=
 =?utf-8?B?TitONE1hZGp2TVhaR0M1bldFc000ZUNSQjIyS21KczVCZ2wrc3RkUzBUZVFF?=
 =?utf-8?B?clZkZUNyRGdJS1EvaHdsK1BoR0RYc3VNblFWcU5ya1FFR3dRQTNnbkZNRzJX?=
 =?utf-8?B?dnYyZTM2UnJROEdOY3dHQTRZRU9aWk1ObTlpWGdRZ1BvN3grVy94V0JSaUZX?=
 =?utf-8?B?S1g1RVVYeFdqQmxpMHVWTEt5ZHAzRnZBTnFEZG4wZVI5TEhqQjRnYzR3N3Vk?=
 =?utf-8?B?Slkra01XRnNyNXVUU1l0QjRzMTk2QTJiOXVaMXNtY2NqcTFBR0VReTFGSmcy?=
 =?utf-8?B?Uk92TlQwTXN2MUZqVUwvRTllNE1XMUNpSXQ4N2E4bzJYSm10VnpGQ1ZIVHB3?=
 =?utf-8?B?eVlCYnBMZ3FGOTYxajRHV0UrWDk4QVREZGVEQmcwSk4xR1Rtdkw3VnZRZGtU?=
 =?utf-8?B?aXFzdXc2Nmc0aEFMY1BHUTF3R0FRQVpleDZiQzlNZlkzaTY0cTJoeFhKLzlH?=
 =?utf-8?B?TXpudzdIcVFDSG0zTGdGUGJ6VzFSMXUxdFc2M0J1am1WaXBaZXpUQkJHeUx2?=
 =?utf-8?B?YVFxZFNxczN5UFZzL0grMGZQNld3YXRoenQ1UVJZeU5vcStwaVRVcW5JMncv?=
 =?utf-8?B?djgvTkhiOU5uQnFqdWJNeXdmRHZYMDM5YXFQaWtXN2hPTHpmUmtYTW5aNXkx?=
 =?utf-8?B?MjkvNGdyaVE1NXpRVDlZQ2tEWnl3M0tsakx3ODBYc3QwM012WHA5ek5KSEx6?=
 =?utf-8?B?U3pzS3RoVnVzamZnMldMelEzV3VpNTJYbkF3eGxEV0NobERNUEJNaThWNVp2?=
 =?utf-8?Q?sxsUYXh6mNlDURTV2FDW4wQm0VnC1TtQ=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc04f9e-9515-4012-e0da-08db3555ad69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 21:43:50.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjDGbcfOeOEWc1yKl+KUoAU5nWNubYqVsQKQUi3DpC5Mrv671lsxOjiuWTuebQPMQXbR8fF+jAC9DhJuInz3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
X-Proofpoint-ORIG-GUID: voKSZoOIphO1OwFn6iN2XXL3lsIl0pIG
X-Proofpoint-GUID: voKSZoOIphO1OwFn6iN2XXL3lsIl0pIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040198
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNC80LzIwMjMgNToxOSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRo
dSwgTWFyIDMwLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IE9uIDMvMzAvMjAyMyA1OjQwIEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gPiA+IE9uIFdlZCwgTWFyIDI5LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3Rl
Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIDMvMjkvMjAyMyAyOjUwIEFN
LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gT24gVHVlLCBNYXIgMjgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+
ID4gPiA+ID4gPiA+IElmIHRoZSBjb3JlIHNvZnQgcmVzZXQgdGltZW91dCBoYXBwZW5zLCBhdm9p
ZCBzZXR0aW5nIHVwIGV2ZW50DQo+ID4gPiA+ID4gPiA+IGJ1ZmZlcnMgYW5kIHN0YXJ0aW5nIGdh
ZGdldCBhcyB0aGUgd3JpdGVzIHRvIHRoZXNlIHJlZ2lzdGVycw0KPiA+ID4gPiA+ID4gPiBtYXkg
bm90IHJlZmxlY3Qgd2hlbiBpbiByZXNldCBhbmQgc2V0dGluZyB0aGUgcnVuIHN0b3AgYml0DQo+
ID4gPiA+ID4gPiA+IGNhbiBsZWFkIHRoZSBjb250cm9sbGVyIHRvIGFjY2VzcyB3cm9uZyBldmVu
dCBidWZmZXIgYWRkcmVzcw0KPiA+ID4gPiA+ID4gPiByZXN1bHRpbmcgaW4gYSBjcmFzaC4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBh
dGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gPiAgICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gPiA+ID4g
PiA+ID4gICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiA+ID4gPiBp
bmRleCAzYzYzZmE5N2E2ODAuLmYwNDcyODAxZDlhNSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiA+ID4gPiA+IEBAIC0yNjIwLDEzICsyNjIwLDE2IEBA
IHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQg
aXNfb24pDQo+ID4gPiA+ID4gPiA+ICAgICAJCSAqIGRldmljZS1pbml0aWF0ZWQgZGlzY29ubmVj
dCByZXF1aXJlcyBhIGNvcmUgc29mdCByZXNldA0KPiA+ID4gPiA+ID4gPiAgICAgCQkgKiAoRENU
TC5DU2Z0UnN0KSBiZWZvcmUgZW5hYmxpbmcgdGhlIHJ1bi9zdG9wIGJpdC4NCj4gPiA+ID4gPiA+
ID4gICAgIAkJICovDQo+ID4gPiA+ID4gPiA+IC0JCWR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7
DQo+ID4gPiA+ID4gPiA+ICsJCXJldCA9IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ID4g
PiA+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ID4gPiA+ICsJCQlnb3RvIGRvbmU7DQo+ID4g
PiA+ID4gPiA+ICAgICAJCWR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiA+ID4gPiA+
ID4gPiAgICAgCQlfX2R3YzNfZ2FkZ2V0X3N0YXJ0KGR3Yyk7DQo+ID4gPiA+ID4gPiA+ICAgICAJ
CXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSwgZmFsc2UpOw0KPiA+ID4gPiA+
ID4gPiAgICAgCX0NCj4gPiA+ID4gPiA+ID4gK2RvbmU6DQo+ID4gPiA+ID4gPiA+ICAgICAJcG1f
cnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiA+ID4gPiA+ID4gPiAgICAgCXJldHVybiByZXQ7DQo+
ID4gPiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+ID4gPiAyLjQwLjANCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgdGhpbmsgdGhlcmUncyBvbmUgbW9yZSBwbGFjZSB0
aGF0IG1heSBuZWVkcyB0aGlzIGNoZWNrLiBDYW4geW91IGFsc28NCj4gPiA+ID4gPiA+IGFkZCB0
aGlzIGNoZWNrIGluIF9fZHdjM19zZXRfbW9kZSgpPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhp
IFRoaW5oLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAgICBTdXJlLiBXaWxsIGRvIGl0Lg0KPiA+
ID4gPiA+IFdpbGwgdGhlIGJlbG93IGJlIGdvb2QgZW5vdWdoID8gT3Igd291bGQgaXQgYmUgZ29v
ZCB0byBhZGQgYW4gZXJyb3Ivd2FybiBsb2cNCj4gPiA+ID4gPiB0aGVyZT4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoZXJlJ3MgYWxyZWFkeSBhIHdhcm5pbmcgbWVzc2FnZSBpbiBkd2MzX2NvcmVfc29m
dF9yZXNldCgpIGlmIGl0IGZhaWxzLg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBr
cmlza3VyYUBodS1rcmlza3VyYS1oeWQ6L2xvY2FsL21udC93b3Jrc3BhY2Uva3Jpc2huYS9za2Fs
ZXMyL3NrYWxlcy9rZXJuZWwkDQo+ID4gPiA+ID4gZ2l0IGRpZmYgZHJpdmVycy91c2IvDQo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gPiA+ID4gPiBpbmRleCA0NzZiNjM2MTg1MTEuLjhkMWQyMTNkMWRjZCAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ID4gQEAgLTIxMCw3ICsyMTAs
OSBAQCBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gPiA+ID4gPiAgICAgICAgICAgY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RF
VklDRToNCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdj
KTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0ID0gZHdjM19jb3JlX3NvZnRfcmVzZXQo
ZHdjKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IElmIHNvZnQtcmVzZXQgZmFpbGVkLCB0aGUgY29udHJvbGxlciBp
cyBpbiBhIGJhZCBzdGF0ZS4gV2Ugc2hvdWxkIG5vdA0KPiA+ID4gPiBwZXJmb3JtIGFueSBmdXJ0
aGVyIG9wZXJhdGlvbiB1bnRpbCB0aGUgbmV4dCBoYXJkIHJlc2V0LiBXZSBzaG91bGQgZmxhZw0K
PiA+ID4gPiB0aGUgY29udHJvbGxlciBhcyBkZWFkLiBJIGRvbid0IHRoaW5rIHdlIGhhdmUgdGhl
IGVxdWl2YWxlbnQgb2YgdGhlDQo+ID4gPiA+IGhvc3QncyBIQ0RfRkxBR19ERUFELiBJdCBtYXkg
cmVxdWlyZSBzb21lIHdvcmsgaW4gdGhlIFVEQyBjb3JlLiBQZXJoYXBzDQo+ID4gPiA+IHdlIGNh
biBmbGFnIHdpdGhpbiBkd2MzIGZvciBub3cgYW5kIHByZXZlbnQgYW55IGZ1cnRoZXIgb3BlcmF0
aW9uIGZvciBhDQo+ID4gPiA+IHNpbXBsZXIgZml4Lg0KPiA+ID4gPiANCj4gPiA+IEhpIFRoaW5o
LA0KPiA+ID4gDQo+ID4gPiAgIEFyZSB5b3UgcmVmZXJyaW5nIHRoYXQgaWYgX19kd2MzX3NldF9t
b2RlIGZhaWxlZCB3aXRoIGNvcmUgc29mdCByZXNldA0KPiA+ID4gdGltaW5nIG91dCwgdGhlIGNh
bGxlciBpLmUuLCBkd2MzX3NldF9tb2RlIHdobyBxdWV1ZXMgdGhlIHdvcmsgbmVlZCB0byBrbm93
DQo+ID4gPiB0aGF0IHRoZSBvcGVyYXRpb24gYWN0dWFsbHkgZmFpbGVkLiBTbyB3ZSBjYW4gYWRk
IGEgZmxhZyB0byBpbmRpY2F0ZSB0aGF0DQo+ID4gPiBnYWRnZXQgaXMgZGVhZCBhbmQgdGhlIGNh
bGxlciBvZiBkd2MzX3NldF9tb2RlIGNhbiBjaGVjayB0aGUgZmxhZyB0byBzZWUgaWYNCj4gPiA+
IHRoZSBvcGVyYXRpb24gaXMgc3VjY2Vzc2Z1bCBvciBub3QuDQo+ID4gPiANCj4gPiA+IE9yIGFt
IEkgbWlzdW5kZXJzdGFuZGluZyB5b3VyIGNvbW1lbnQgPw0KPiA+ID4gDQo+ID4gDQo+ID4gTm90
IGp1c3QgaW4gX19kd2MzX3NldF9tb2RlKCkuIEkgbWVhbiBhbnkgdGltZSBkd2MzX2NvcmVfc29m
dF9yZXNldA0KPiA+IGZhaWxzLCB0aGVuIHdlIHNldCB0aGlzIGZsYWcuIFNvIHRoYXQgaXQgY2Fu
IHByZXZlbnQgdGhlIHVzZXIgY2FsbGluZw0KPiA+IGFueSBnYWRnZXQgb3BzIGNhdXNpbmcgbW9y
ZSBjcmFzaGVzL2ludmFsaWQgYmVoYXZpb3IuIFRoZQ0KPiA+IGR3Yy0+c29mdGNvbm5lY3QgaXMg
YWxyZWFkeSB3cm9uZyBvbiBwdWxsdXAoKSBvbiBmYWlsdXJlLg0KPiA+IA0KPiA+IFNvIHRoYXQg
d2UgY2FuIGhhdmUgYSBjaGVjayBpbiBkaWZmZXJlbnQgZ2FkZ2V0IG9wcy4gRm9yIHB1bGx1cCgp
Og0KPiA+IA0KPiA+IHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKCkgew0KPiA+IAlpZiAo
ZHdjLT51ZGNfaXNfZGVhZCkgew0KPiA+IAkJZGV2X2VycihkZXYsICJyZXNldCBtZS4geF94IFxu
Iik7DQo+ID4gCQlyZXR1cm47DQo+ID4gCX0NCj4gPiANCj4gPiAJYWJjKCk7DQo+ID4gfQ0KPiA+
IA0KPiA+IFBlcmhhcHMgdGhlIGVmZm9ydCBpcyBwcm9iYWJseSB0aGUgc2FtZSBpZiB3ZSBlbmhh
bmNlIHRoZSBVREMgY29yZSBmb3INCj4gPiB0aGlzPyBJbiBhbnkgY2FzZSwgSSdtIGZpbmUgZWl0
aGVyIHdheS4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4gDQo+IEhpIFRoaW5oLA0K
PiANCj4gIFNvIHlvdSBkb24ndCB3YW50IFVEQyB0byByZXRyeSBwdWxsdXAgaWYgaXQgZmFpbHMg
dGhlIGZpcnN0IHRpbWUgPyBBcyBwZXINCj4gcGF0Y2gtMiBvZiB0aGlzIHNlcmllcywgSSB3YXMg
dHJ5aW5nIHRvIHByb3BhZ2F0ZSB0aGUgRUlUTUVET1VUIHRvIFVEQyBzbw0KPiB0aGF0IHRoZSBj
YWxsZXIgKG1vc3QgcHJvYmFibHkgY29uZmlnZnMpIGNhbiB0YWtlIGFwcHJvcHJpYXRlIGFjdGlv
biBhcyB0bw0KPiB3aGV0aGVyIGl0IG11c3QgcmV0cnkgcHVsbHVwIG9yIG5vdC4NCj4gDQoNCk5v
dyBJJ20gY29uZnVzZWQuIElmIHRoZSBzb2Z0LXJlc2V0IHRpbWVzIG91dCwgdGhhdCBtZWFucyB0
aGF0IHRoZQ0Kc29mdC1yZXNldCAoc2VsZi1jbGVhcmluZykgYml0IGlzbid0IGNsZWFyZWQuIEhv
dyBjYW4gd2UgcmV0cnkgaWYgaXQncw0Kc3R1Y2sgaW4gdGhpcyBzdGF0ZT8gTXkgaW1wcmVzc2lv
biBpcyB0aGF0IHNvZnQtcmVzZXQgd291bGQgbm90IGNvbXBsZXRlDQphdCBhbGwuIElzIHRoYXQg
bm90IHRoZSBjYXNlIGZvciB5b3UsIG9yIGl0J3Mgc2ltcGx5IGJlY2F1c2Ugd2UgbmVlZCBhDQps
b25nZXIgc29mdC1yZXNldCB0aW1lb3V0Pw0KDQpUaGFua3MsDQpUaGluaA==
