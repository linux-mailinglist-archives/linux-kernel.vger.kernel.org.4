Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC23724098
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjFFLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFFLNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:13:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423118E;
        Tue,  6 Jun 2023 04:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6E3PGerVRyYuM+jOv+2bA3zzvThXzXtW33UM0YE/rt/lR2FbTdmvK8XhUJtsEYZ7v0m11tkDMoKmeelST2bd8NRdp7fOXqQBDF2/vJEVE7uBi35I4i10ovEvbSBBXmxjTs2NmfvQAwsaxa/88zobyLMmZ8CtG4OG1Ti2Yx3WVMxxJY0lv90k7RbqT7pIbqGRGHGPWKprEbgbRG/9fwUDyCswAZonu0O9Xi9F1r6fvQtw3hn9qao3JvCxns0UiSKLz6C0t9aX/iNMvFd3l77TpizYFFBQ+H/lXZ+8GfPAcIT2NeRxHSfihu8fSP+67oEiDiXsrb+AQ9ExeeVdrSyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHuX6ORemklMQ49DrNMldhQElpzpizmbcx12jJ7ePDU=;
 b=aVLgY50Ay3FmF4TrI24uPPxLLIFbJ3QMs4Z/oUD0sD3qS9LfCBc0NbmfJtc/NumLHU3kyt6sdaG1IuMBOdgR7U4HeeLLr6M6QrP0OnZ+tRIwZ78Mbtj4cXgawtVSdreF7c9s4sBIHrH54JxLa0S2M415tatVl31D65kqvCsFtqS0svU3z2WslNeHMwBwaUWnBeunO629M0saIq+fMM5VvWWCg2xtnV1UDoXWlE6aNgjDPkB1RLvZZPlr1t9G0HeLl+4gd7AtWEIWo3NKbjLYnpnAlH9HY8CimG35u9LZUJPHqKMLuPGTpM2TclnxMMnPjnr7Q96QwMTQ09kHgtOgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHuX6ORemklMQ49DrNMldhQElpzpizmbcx12jJ7ePDU=;
 b=gn5uWpeotqE7/nJ7Gm1dsqOGYcf0A+plnHcr+4apkW5s3EhyFhSNytUbHMISeMUiHVgevljpj5+kjA89A/TX09tG6TjNBeBvQfVGoHnYuJwnLOuGCR0I6L+c88sXxOCF1My7Owkwj/t7cVMAyBSe7+I+drwxqv1rSdWn+FnR8c1JoQyZV/pdeqC1Zym4LEMn9/r87loD3cCCnw7wcIwjYzznXGupaNw4FulDSvtBdXQ4W6wUQVXriy31S/Xj0y9qwYOFUb7/NbjF59rqTLPSzkeVFYNzbf1KgoCrggr5IdiYZ5rV0IllVFTY5eyIRGQHQoaL5zp1OBuXxQEE0MJPFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Tue, 6 Jun
 2023 11:13:33 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::db34:4ec1:a01c:951b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::db34:4ec1:a01c:951b%4]) with mapi id 15.20.6433.025; Tue, 6 Jun 2023
 11:13:32 +0000
Message-ID: <88472624-cc92-31a7-f35d-a212e61ab959@suse.com>
Date:   Tue, 6 Jun 2023 13:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] USB: serial: return errors from break handling
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
References: <20230604123505.4661-1-johan@kernel.org>
 <20230604123505.4661-2-johan@kernel.org>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230604123505.4661-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ccb598-17e9-417f-dd8a-08db667f106a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62yMZUs/J6ZQ4MQdZjbZE1UEZN2dwACGfjaGGu+NHFvvhcGNloJ4ZYQBpzu9O9GtfnG0URVkQ9qK84XLWsf6YKm4Oog0bsNjYqLk6tbF6iyyy1kOoxpjpDEdhN9l8jXlBlRDFGSHGIh3Wfisv3tRfObdcaFn1+2f5E6Rv1KeEitS5Sv35o+6wd7tR0JEu8wL0po+5E7YFVISTg7PUjEcv/9N0R0+zI+3r4nrrsGmLvgw7EdTQ42XeW5zvooWCMv6B9+owWyuDOfjb+K+tIDTmWD7yw2DJ4rXrhGHJm6vxc/bJqk2ViMnIt1s+9Wa3vIqMG0vZ7CdFgQY6n85i0cXqHmeC8UyXRopz3PODB1v3ZRbYOMYtDUyiiV6NM0XNeHFKz6Yh788lVwnbiqKCAIkzMvS8Fptrgdg1NIyQS+ngXoJgVo8LtQsyt4ZqmZnxnzFa+oXCGgzbaw/jBAp7kcrjdjTgyrcz1h84VFxLpSgh6w4rRks2Hgb+CvjI1ZOk0ysNc4W4AAvyxlYEmy5Sw8FbYCz00pS0ACiK77FDvr7ajcBH7yewI7EH7DC7J16SxQhGdp5qT8pfAScVSoEbdfKwOQNtLY5LD2rU+BOxEC/1TmF4NPEuuYAVT7ns3pkc8WKCZ+3y9jnTKF176lR7mMf8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(83380400001)(2616005)(36756003)(2906002)(4744005)(38100700002)(41300700001)(6486002)(316002)(4326008)(86362001)(5660300002)(8936002)(8676002)(6916009)(54906003)(478600001)(66556008)(66946007)(66476007)(31686004)(6512007)(6506007)(31696002)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZGelZBMUc2SXVnK0hRWmtHREtXSGtTYXZPRFZML25vcUpPeUVGTDBnaXc4?=
 =?utf-8?B?aWlVVXVyYVlGdWp6eG9yTzZQVEppaFg3K0FqQ3NTQWZPclFEdWNXVVY5ZTBq?=
 =?utf-8?B?Q2pkS1pZR1dMNzR2VGcrMlNpMEgvK0pUWnlzTnJWR1RoZFc3cTBIU21hcUlo?=
 =?utf-8?B?cHNxdlhmNCswaVFtR1hYSjFQWHJJOWl2VDU5cGN4OEF4UXVtdnJrMGd6QXBr?=
 =?utf-8?B?TWlTQk9oMFA2S0FYeDFGWVh5UFhGZW5oSlAvRWl4OExIajFTRlhESnk3cEVm?=
 =?utf-8?B?L0o2WWQ4V2hiRWIxUkwzS3AzYzVCTEpiN1d6aFNyaGJyRlgvekRSWnZvbVJ2?=
 =?utf-8?B?dWNmT2haOUZRTDhzUll5eGlwVm13d1JCR2tVNzJSUzc4a1d2VVFrT1ArazZv?=
 =?utf-8?B?eFk5L1AvQjF6OGNQd29LTlVDdzJ6U3A2TmJwbkJvVndnWTdJZld6MU05V1hS?=
 =?utf-8?B?cG4zbkozOXpoZW04TG5ocTdEVUw4WXJLK1Q1Zzk4WXQyRG41M1NTSTVlRks2?=
 =?utf-8?B?TTVWMG9oVFh3K0FwUHZudzd1VjRYaUFhYm02QVBXUy9ubTQ0U3B5YUlVNUhR?=
 =?utf-8?B?c2ppbDR1TGVHT3A1N3hveUJJVDBmQmkrZkpZK3RCT1pJd1pYVjdCRmJsQUti?=
 =?utf-8?B?Z3lVQmJ6WGFOSHg0WmE5RmIvaGlUNTBZdElJelk3YUM5eXlJU09nSUhSOGdh?=
 =?utf-8?B?RzJSWEJSbUxHd3MyckhnM2xBeHlSZmx5M3lvMXZxVGNYSzVET2MrbmUxMkhD?=
 =?utf-8?B?eE9OR0dMOC9SMHVVTlBjRXZpa1k3Ny9kbzJIVHNXRE9Xak5LV2ptZ2FaR1pL?=
 =?utf-8?B?akxFMk1QR3ZSRzE5Q2JPemVJdGd5SDVuUHFBRUJvVEZMcXBncngvbmMzbVNC?=
 =?utf-8?B?RmxhNXR4MGVpWlZFdW1FVGY3MjY1cXpyeHdTOFFxWTZpU2tPMVlsd1UyQ2Rk?=
 =?utf-8?B?RGFhMFRmTDVIKzlMSzkyZTh4YitnN0hKRFJWQnNBL0ZveXdPbWh0Mk1KVmhU?=
 =?utf-8?B?dC8xaWhUa0RjeFZuU1MxZm5sbWxNU3RZd3JWOHFsSVdzdDF4L2pBcWNNbmZK?=
 =?utf-8?B?VW4zSmt0OUhZU1NmUGVpUGFTUHRiZVZzUzI5c2ZWTXNDeFJXSWoveUpxdTJi?=
 =?utf-8?B?Z0ZCZ25BeHJFZ0h1b1pXdm4wR29WZVg4R1FncUVDalV4WDZQRWx1T2owckpJ?=
 =?utf-8?B?Z2Y3cXVvbDRkTHFJVDRlcUZSUTY5dXQ5dlh2UzVIc1dnVVFzK0dxZFN0THp3?=
 =?utf-8?B?cVo3MkQvR0xiclpVdXJoYW5GT3BmdVBlQjdHQWU0TXRWd2xDaFp5OFN0SGtW?=
 =?utf-8?B?NTNZcHNHU1VIdnN6L3QrdG9sMzd1OUJtLzRpMFd6d1l6UHd6Y21Pb050NWZP?=
 =?utf-8?B?aUlWdlZPTER0ZU5IY2NhUE5GYWdLQnU3dk5jbHNXQU9xajV2NkhQK21XaGtv?=
 =?utf-8?B?RXdZaUVBL1ZaTFZJUVk1VHlleHNKZnhLOFVwclBkditHWExpL0J1aDZJUGwz?=
 =?utf-8?B?WEtSRzc1QWZSL05mOWtOQUd3NzVpVFdWZkhNU1RLU3huemE1QTJzQVZJYTVu?=
 =?utf-8?B?WHdaakVsQjlvS05XTXduS2pzUHFGeHhNKzJFZXRFUDdielRIeTVlQVNBYXpz?=
 =?utf-8?B?Y0NtTTJ4bU8xNEVIUUVxWG9OdTJROWJhQUVGVkN5NkZ3TDlCanlnWEZEZU5v?=
 =?utf-8?B?S0VBZ0ttVkQ2Rks5Wk5YcXR0OGdGUGg4S09RNk50WDBsZVNpNUtiMG85MHRy?=
 =?utf-8?B?M3FCOXNmbG1YSFZKYUY5ajAvY0QreisyazI3TVRGVHlPWFV0ejFKS0IrUW81?=
 =?utf-8?B?NGczZDZPRTl3ZUZ0eVJiK3RJSUJaWTMvYlIrZmNUdkljWWhYUFEvYXVBeUd5?=
 =?utf-8?B?aG8zSlpCTDdXQnUwMGZhWkFrTXB4MlNmVkN1S0hpWUI5R0tUblBVOVlRZ29I?=
 =?utf-8?B?ZnUxKzkvbTFVcXpmTDRTNWNkSklYZFREMDBFdlJZL1l1ZFJNeEFFNWpjL2Jw?=
 =?utf-8?B?TUlrTUkwdEdoV0ExY01TV3J2KzExcWgxS1ZzRnpTU2RMTGh4Y0I4QmpGZ05n?=
 =?utf-8?B?RHNMRjhJY3lwT0VqQkhNM2JxNlMxQWFUK0lGR1J2czAwVDdRZXBzZUVKWFRq?=
 =?utf-8?B?a0lKckl1cFRQemp5RDVlNUh3elRiSzV3VHNGeDRMdnVLQ3ZRejlXU2hDQnVK?=
 =?utf-8?Q?Z5flaqMtiVjwpBY+MuGc4aY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ccb598-17e9-417f-dd8a-08db667f106a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:13:32.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEMPXc4Js7/O372978uTApwj8bVpmsd5y+4UJNaTqfYVdL86NWY1HcyZPnQXJAngAi6FRL3hEHLbaax/rURawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7644
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.23 14:35, Johan Hovold wrote:
> @@ -1077,15 +1077,19 @@ static void pl2303_set_break(struct usb_serial_port *port, bool enable)
>   	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
>   				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
>   				 0, NULL, 0, 100);
> -	if (result)
> +	if (result) {
>   		dev_err(&port->dev, "error sending break = %d\n", result);
> +		return result;
> +	}
> +
> +	return 0;
>   }

Hi,

this code was always fishy, but I am afraid it worked by accident albeit
spamming the logs.
If I may quote from the kerneldoc of usb_control_msg():

  * usb_control_msg - Builds a control urb, sends it off and waits for completion

[..]

  * Return: If successful, the number of bytes transferred. Otherwise, a negative
  * error number.
  */

You need to test for < 0, not != 0

	Regards
		Oliver
