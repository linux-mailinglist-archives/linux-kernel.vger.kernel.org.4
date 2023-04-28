Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62176F1FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjD1VDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbjD1VDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:03:37 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBD1FCF;
        Fri, 28 Apr 2023 14:03:32 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SH3aag023040;
        Fri, 28 Apr 2023 16:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=npzSJ9ryNxCBKiexif5ls/4nny8H5bU02+9CQubsspc=;
 b=HbVHtXMBKOWd8fubPxy7A07P1Dd+Oon4ex34rmbLmJRgBUhQhoP4qGcIBhlSS1VpL1BR
 zPjqlXgYxsP5cua3ETCHa2uJq51Z2T0QtxdnXArrE6InssoD6GRyTlwz1MyULxS35llQ
 /E5LCyDv5odAWPzveFpYuP7JmhZwzDT1nQXKmQ4R+HGIvZy2RWSgyOCGvqJ33MFjloxk
 n59V9oSLN0HOKs+Q0jwP2N+nNMK0X3N9aHlX5XBS8SBu2WSu9tAz2o4enNc8weCPmFeE
 mk1KxzWUTbsMJ02cJC3FmUt5k1Sa8b8V1abmS8eMYo5WC/UCdtaDcQGdae1LS0Xl1ndr uw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3q4d3vp2pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 16:03:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPgGyrJ0y+IGMUZD2aOLvSg4nut3scoKhqPw1ca/+6YY7tFds5zdBe6qJ/aJkGOvar2EBQxTXUeI0rP/pRhUBl1YkGuYFcYR30jvnrMErXHPkfuPkz1qCnn207Xe5RbnSA+4EUlt0Z3JvbCxxn8j2RAQ9i4o4+2r4GI++7o+TWLCS+WsBYYIEIkL5Dy49wA/WrmakgQDOGUVALls/RuwL+3Bb6bTeIRtLpKhFC8Z+gunl8K3ii7i5jAD9/HK8jTa7dMcb/bYJX0/3O9h0PjcWlred4u5eF2Ff7lRdYHHKG9VVLt4/HEPtalAFDSA3Gzio67FBcEeyuCl3T0octbluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npzSJ9ryNxCBKiexif5ls/4nny8H5bU02+9CQubsspc=;
 b=US7jjc18Km1/rWPOoDChlgOitylQwLffGmKIpqviexZKasqhLtrqZhrEo4ta3rg2ydHJzzRKpHY99vu+V0GGTHnypuM4OE6zQJaebuiCuTpxi1Lbfl7zpNNNEVRcfNi5+d0HZN43GVwOvOLIZ4OZ1rFKuMZdhQv+dz+NQupe8wUsyKCKJIwZWh4PD3+5pVxbTtzARTHXR/M/LNg1Aotn1GqxU9GZc5QRrzYzToMrmuRgbYxqRPecW7LJ+3nZarG9sutjqV/95Vl4xbkAw8miAPx357lJvbdOJhckcAooq+orFh1lY9s6CEhYllZ0IueK9gQIiBIQVGAF785kwzzyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npzSJ9ryNxCBKiexif5ls/4nny8H5bU02+9CQubsspc=;
 b=AajZc7XVBDB5QycZhpQfbtyJhV37dKDSAc6fofMOh8R9zGdnWKtUFk7j2GMj/8nYlstIktrVOTH8flj2Np65fC/e/e7hSg51Efh6tOzeVCFcA2FknQ7HIxMqn/ww8aUTUHXyGLhjlWStP/gC+TWZFwua81eAp3z37PsWYZ5rcZ4=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7486.namprd04.prod.outlook.com (2603:10b6:a03:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 21:03:19 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 21:03:19 +0000
Message-ID: <f6df7da0-b4c0-0f34-ffe3-6b9ff1d6a2d2@ni.com>
Date:   Fri, 28 Apr 2023 16:03:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230418223800.284601-1-brenda.streiff@ni.com>
 <20230418223800.284601-3-brenda.streiff@ni.com>
 <9cd84bb0-864a-af70-986a-841ac1f522e@linux.intel.com>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <9cd84bb0-864a-af70-986a-841ac1f522e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf6f1f0-43ba-4682-0ec5-08db482bfe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTgIoq5ypHlC1kPa/KdYqXNYiKfZMbq/X6bNNW4OAroUu9TW9pBzMkceWCySO4WIcmL9geoUFY8jnopXZxgUgt/Ma4BL8p1nvEN+dy9bRdVd62nyNDAg7Kmtj140ZIrbEObOZy+iYrPcGXZ27wH7AebfGW+2I8p4TiLOOQhaEBOX+BPca68beVXyfZkisb2Z1Opg+gJZKlI0XW5Mp/RAnzGEOmed3AObVDyuZ599UOy8nVWRR+uezqbiDe2RsSduQMsCWuJ/w9+f7ILJLnCoOQk+ZrAbWBTmlQtYf+gbBxLubZtsLQ8ade7oXVYD+fktTRfEsa3MrtyUKsF7NokSkrY3/HKCbVNdZnHpAS25+GHxLPOjd9OqqMoswhH8wkikYsFabXnU4Ftt93iDcKgsV0qB/U4vtv7715OzsT3ggxL00mBdGQTRRj3uX4QGFl675MIt4hI96R+/SkKCV1Fo3QEkxJAwTxWBOFatZrDvItkB9a9kmXU1lZWHMVW46jMFMGBDGBmpaW3CONGw9fHB+Xn1RbZbaocZJNSuxKZTh3wQRJzo+ZotxNqkNmlN92zUAP5gXfFrF4/zV1eQQuLmOHOI/HBxMFv6DM/L0EeP4uFBqsbvO4GgFUgLCr4LRI8h5257HvDPX11S73szqHHNBXHl4EsaTi0dLXn1kaLMRv67HLIk4pZ5pxCszmck3yu5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(66574015)(83380400001)(36756003)(31686004)(2616005)(86362001)(26005)(53546011)(6506007)(31696002)(6512007)(966005)(6486002)(478600001)(54906003)(66946007)(316002)(66556008)(4326008)(6916009)(66476007)(8676002)(41300700001)(8936002)(186003)(2906002)(38100700002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWMyOTN0OG1uQVhnUHR6N1E0QUhDdGVFbmhvMmJuWm9qRENDQmpkTGZUbDRB?=
 =?utf-8?B?L3gwSU1vNnNVSWdwTnRpKzNEbC83Q3F3enpxNGlvbFlEeVlaYzhmWG11TndN?=
 =?utf-8?B?eTdCV3FKQ1dURVI4MWhVK21FT2V2amJ1b1BQZ1g2Snp5K3lkMEJndGQvQnlm?=
 =?utf-8?B?VG9BZmV5Yi81MnFCWWRFemQ1QVRLekY2a2FBR2tjOWFhUEtseTllemNqRDFV?=
 =?utf-8?B?L25nSDRjc3I1VXpoOFR6b2NUOHUzUmVlcFVMdnlQYjZqeXlSSjZhTWdjMWVW?=
 =?utf-8?B?a2gzL3Z1RWNQajhjbzRXRFozMGhsakdxaUFHRG5FVHdXcGRkbHc1VnNyaUFY?=
 =?utf-8?B?dmFUblBjOGZ1NFlJd0hidWsyaUhTZFJJZTQvb3ZOa3dTUkxOaEJUcytXSDBu?=
 =?utf-8?B?dXBVOTYxd1BpMzJ2ZTZRNnlnaUFPTzAzZXRlVjNJNlNZYzZsRjhJY2JRNFpC?=
 =?utf-8?B?MXpGN1N5WFdxYmNOTFQ2UmZwd3lQQytKMDRrU2cyZ1MrUEpBcnJmL3ZOd25M?=
 =?utf-8?B?ajVwOVZ5WnE3N0N1Q084SkI4NVUwV2ppYUhPa0VsVE9SeWFSRWw3SG5zeEN0?=
 =?utf-8?B?NE4rZzRBc0svZzlJbktaeTFGNHB3RGRGa3Z1NEU4ak5WVUdzdWN3YWhVdGJu?=
 =?utf-8?B?aXNDTE9Ld2xkbmJ6YldGYWdHTFhyY2hFOGdXckRYWS9CT2pzenM5eFhwMlpH?=
 =?utf-8?B?Z0hOTXhCaFVqOUdaQXFoT0crbHpsUm5HZHVtb0NzbHdMeFY2Q2MxTHlFd0pK?=
 =?utf-8?B?a0NTcGRVbjRQOFVseEZPWXpOS2duUlpBS04xd0pGQjl1aDNrSXZQc0FxYUFI?=
 =?utf-8?B?UHJGTThLN2wvZkV6V1ZVNElGSUtJSnBaRDg2N09ONVlFbWY2eHFCcmlkVzN2?=
 =?utf-8?B?Y3k2ZFIzVW5EVzhSWFVWUWxJenB2T3dJYThXSWZFNWsrMUhncW0rZGRpeVUw?=
 =?utf-8?B?eER6WnFtQXZQMm53cmFQSzFTVHdqNUFyWTNzYmRRZCt2bWIzTmhZd1c4YXFl?=
 =?utf-8?B?UkN1aUVLTGJPZTlaVkRSRUxYK25ORmdXZnd6RVh3azQrTk9XbElyb3Fnd3BZ?=
 =?utf-8?B?UnZzNk1JRVMxMmR6YlBab0V4cms5ZDFCcWZHdGE2NTRVbkYxV0lhdjdWT2ow?=
 =?utf-8?B?REt3VGljb2FaMktHcmdZSUprTWV1QmFZYktDd1VwUFFLeitUWDRRUStqc1pF?=
 =?utf-8?B?OFdRLzVkbW50NWwydTBXcUdQVVdpL0ZVdXQ5aTRNdHo5c0Qwdk9RVldJaC9i?=
 =?utf-8?B?a3ZKUHR6V1dzY2RPSGpic0xScXRSWkwyRlVKQ0NBdmhlRm4xV0dTKysxak80?=
 =?utf-8?B?WXFwK29xakw3STM5WWRHWWY2K1FPbjQrNlZvbktGaFVYcXVrRkpOaHlJS0Rn?=
 =?utf-8?B?WVNCdDR2T05PVzBjVU8zZ1VlamY0K3dTVE1qazQzaXJLSU1BREo0OWEwUkVr?=
 =?utf-8?B?WkpueldueWRDQXRNdk9wVkFpSDF3MFZSdGZTOHdzL0Z5U3MxSjNXZFF4WEhm?=
 =?utf-8?B?UXpaNUFMZUEvdEhxMURZTHI0Z0EwK3c5c29aalhjeGpVMUxaVS9YVENIWVJZ?=
 =?utf-8?B?UTdjVEhIbjFtRzBBNTc2Q3Z5RVRrMkhpVzl1TU0zcTZuTzZFSkJGRmpPK1RF?=
 =?utf-8?B?V2Z4elMzM3lRMzMwaE5LWTN5UGpteS91RUkyK210RHFHNElLQng4ZUJXQkQv?=
 =?utf-8?B?T3ZMdlJkZXMzVldBMTJ5eTZ0Wkg0aXNpRjROejVrN2VEUnpqQXdmQ2cxQ08r?=
 =?utf-8?B?UG1mNlZici9ENnRUY0FGaWYremtBK0F3YjFCQ2RtOEIrTmRSRk1hMEUwTmFY?=
 =?utf-8?B?dXJKV1dySVFwL2tTL1ZTZE1TSjk4V2NQeWJocmZkZ1hBQjJNRm95T0RUc00y?=
 =?utf-8?B?Zm1uQXltMkJCR2xYV2RhUjF6VzNhKy9Rb0tENjFFRE15S1IyRjVqNkNwMkN3?=
 =?utf-8?B?NFI5TXF0VjNZcmErSlNtTVAzOG1qM3lSTkpjVHlWTUc2YnhHeDA3Lzh1REpq?=
 =?utf-8?B?djlvR2VYVWF0ZG12QmJtYW9xa0VsclhCaTNudmFxcEgyWUNPNmV4T3hWVy9i?=
 =?utf-8?B?K0dpbDQrUXpscVhyWVQ0ZTBWV1Y5aFM2dGRTVWJZVlU1V2JnOUR4UGgwVERI?=
 =?utf-8?Q?Mk+O9kHlHmmWq4edpGIq9l3CL?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf6f1f0-43ba-4682-0ec5-08db482bfe94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 21:03:19.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H88g1DbubqOtmoWeU1J8RrfYapf8tngVraPL0HTSHOaBGP+iQPoTVqRhm4/9NptWpcFOJ3wUMEj/YtX4lFssSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7486
X-Proofpoint-ORIG-GUID: i7-4blQV0F9Y9LdUQhhl0Rlw6LC7ukpb
X-Proofpoint-GUID: i7-4blQV0F9Y9LdUQhhl0Rlw6LC7ukpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280173
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 06:43, Ilpo Järvinen wrote:
> 
>> +	pcr = serial_in(up, NI16550_PCR_OFFSET);
>> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
>> +
>> +	if (rs485->flags & SER_RS485_ENABLED) {
>> +		/* RS-485 */
>> +		dev_dbg(port->dev, "2-wire Auto\n");
>> +		pcr |= NI16550_PCR_AUTO_RS485;
>> +		up->acr |= NI16550_ACR_AUTO_DTR_EN;
>> +	} else {
>> +		/* RS-422 */
>> +		dev_dbg(port->dev, "4-wire\n");
>> +		pcr |= NI16550_PCR_RS422;
>> +		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
>> +	}
> 
> Does this difference also mean the UART's RS485 could support
> SER_RS485_RX_DURING_TX? (half-duplex vs full-duplex RS-485)

Maybe. At least on some devices it appears that it might be possible to
support this with a combination of the NI16550_PCR_ECHO_RS485 mode (this
is "2-Wire DTR Controlled With Echo" in NI parlance [1]) along with the
AUTO_DTR mode set in ACR (which asserts DTR if there's data in the TX
FIFO).

We've never tried using it in that way (neither in prior versions of this
driver nor our driver for this hardware on Windows), so I'm not sure that
works that way on all revisions of the hardware, so I'm hesitant to
include that in this patchset for now.

[1] https://www.ni.com/en-us/support/documentation/supplemental/18/transceiver-modes-on-ni-rs-485-serial-cards.html

>> +
>> +static const struct serial_rs485 ni16550_rs485_supported = {
>> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
> 
> The driver does not seem to change anything based on the value of
> SER_RS485_RTS_ON_SEND, was this an oversight or is RTS on/off on/after
> send not supported?

Not so much "not supported" as "doesn't matter"?

SER_RS485_RTS_(ON/AFTER)_SEND (which would be a misnomer anyway, as we use
DTR and not RTS) appear to let userspace indicate whether or not the
transmitter is active-high or active-low, under the assumption that the
UART driver doesn't know anything itself about its attached transceiver.
This driver does, so it doesn't need either flag to do the right thing.

However, there is existing userspace software does try to configure the
SER_RS485_RTS_(ON/AFTER)_SEND flags; for instance, pyserial's RS485Settings
sets rts_level_for_tx=True [2] and this maps directly to RTS_ON_SEND. Our
own proprietary Linux software also sets these flags. So the behavior we
want is to we effectively treat them as don't-cares here.

I can add comments on that further though, because I can see how that looks
a bit confusing.

[2] https://github.com/pyserial/pyserial/blob/31fa4807d73ed4eb9891a88a15817b439c4eea2d/serial/rs485.py#L22

>> +
>> +/* NI cRIO-904x RS-485 Interface */
>> +static const struct ni16550_device_info nic792b = {
>> +	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
>> +	.uartclk = 25000000,
>> +	.prescaler = 0x09,
>> +};
>> +
>> +/* NI sbRIO 96x8 RS-232/485 Interfaces */
>> +static const struct ni16550_device_info nic7a69 = {
>> +	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
>> +	.uartclk = 29629629,
>> +	.prescaler = 0x09,
> 
> To me these two comments don't seemingly agree, one states 22.222MHz and
> defines 25M clk, whereas the other states 29.629MHz and defines 29.629M
> clk. I guess one of them comes from prescaled and the other from
> postscaled frequency?

This was an error-- the comment is correct, I had the uartclk value wrong
(should be 22222222).
