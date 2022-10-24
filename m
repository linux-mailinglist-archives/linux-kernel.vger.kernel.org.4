Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906C8609E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJXJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJXJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:40:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F0357CD;
        Mon, 24 Oct 2022 02:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeczaxNMuZsmnw0zszCVGVs20GS7gvaUP7AoBu9FAaaS75tqQPe1RMLuPKrbNejZaZdsRYAs1WbuWsUiYYhSFu8ORlXA4BncubnoSqTnVXJB6q8mP6Nft81gHc0qgQSAoWyuxdsnU4Vurzy1Rg8q8O3rfjka/yDDd5qAlBIm41nnT3IAonVy52HiB1f3YjWaZlyfO9j3WaPUQrutUd4EczGC+rwpDxGHihp0ysAs/4uzvsFrzXNwLcvN35ISkZJd0oP7QW4LHY35BPzu8jN57EwOohIX2pcZrS/TfCT0ir5X4FgBW92wei8hd3OgW0nZB5qOefbe9MkcFPHcmfPHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPRn2e4V6HLpNV+l7vYW3EvknRW+bYng6RbHPcyLbzg=;
 b=V8/XjmkWnN5YkcKl41zsdeJ0eMZH5+CzE70ZoVodvvfrzHBOKy/JaBg27Yz92Y50V2RZzZOcWOD/10JtzVo8KzZm+WMCEVSEUK3cchtYHXzUiyO0nq+VJs0iv60nysFuJjuRB72fuFDaUUiyNMy0upIWWYIfU8Wc/sElqYXJSErhXs6YdPMuNAyzDXjZbM+aVWV1N2a5U2OMABhm4T/9RzdjTK91pxPWspb8LMzpFKQGlzOOM7if2Niig+oNOtr5j5FspbxVY1Ovh0hC7dwJQ2JD83EgFWcOjWsE1602flO5WRDnxg3xKXLwf9o9rs0FB/tHVEAUaPEAtiEpcOpv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPRn2e4V6HLpNV+l7vYW3EvknRW+bYng6RbHPcyLbzg=;
 b=vXKqNlNv5xlRejS/Nw6jvvR6svUX6Wd9YCIqrdZNWkQxT59j/pkKGUd7Sh9ZtpRePr7CROdA9DsEYqzrwV6FUMWhiYLOZ+Lc4e3DRMfTwDkGfx6vsjxGFffCkBtjL+LXOveYTeA5oqCEsKcTTEiLLra+NLh0nW9PF4/eh9y+Xn/ZMwDXjIeFxfGtAcmUieTu6VK6iNHfJCLJPRVXW6lwbCtlJI+mD92Z0ZYhBC8YjPFKSSGNE+5GUKC3386tE+3QpjPNlwdQLcM6iE6q4M9RVAHgbHD7yPbSZjkN+wmX5AycjZ3kNTfpdPwIQl2+TViz4qNvvCWYZnUboPYlEQQD3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB9PR04MB9648.eurprd04.prod.outlook.com (2603:10a6:10:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 09:40:19 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::1bf0:ae5a:ac96:5dea]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::1bf0:ae5a:ac96:5dea%3]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 09:40:19 +0000
Message-ID: <135c51e3-56b6-cdf0-3499-cd354f43601d@suse.com>
Date:   Mon, 24 Oct 2022 11:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] usb: serial: add support for CH348
To:     Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
        johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neil.armstrong@linaro.org
References: <20221021133758.1881904-1-clabbe@baylibre.com>
 <20221021133758.1881904-2-clabbe@baylibre.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221021133758.1881904-2-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DB9PR04MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd6adb4-adf8-473e-025c-08dab5a3c36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nHB8qansXMtiuFeowav31QIIw/7O76Rk0nG8A3MqvZIotC+XBnh3EX9lHsJnV0eB/HiUDhYKl3x5I4vq9ru2TvaBBQZZCGpzJ3e498qDW1Z5BDJ0LOvH/xlR/tBNojX9LdL8yjEFpkHPcPGe9dtWPKYSPipb8Ogio1NJKdt3ONevlDNF5tmXLtX4TctJir+JoBOLdooPbX5t+F1rgT7CHPP6fX1W0Vzy6H2HwlIepMLUCPvKUfUFnUzf/k/RiM7TTS01dPdeHjjDZ7GLI9+3WboBSMUo4nhxJa3Ht0VehA2pPGIi02bhmtHxG3a0UwhiL7qZJZPPGD3n12slE/3SMgGlT4pI4yZmcuosuPHcqFhESI+AU5x1WmO5wLBKDsFU8IWMmYyo0MoMY2WEj8G+vnaAcMBQufj+wSkfwo8o0szuIHqjOKfucPVjQD/c6CPyI3tbOH6ZE/D/wpyvrnBdPZAWZaAVufZYJN343vHost4DZZNIWGlPEqdfjC7XD097kL6KvynUBq4HGwcv67db0qxa9oDxtVaPzKxoRR+VD3crzMBvWCnBKy/UNV4WCCWYKW4aIXx7HKbYxvBLJAeU2oijCzrUsoRI1E+r9wQUHK1BBkj6O4dwMHGNEzb1bBa0x2mUP15ivcd+OD5EFPPv/bBOSO9kJgyUpzBiMUmsELdUVsJMR725r/849H7qZUNn6C9/HN8Wp++sRc/9/5JOvQasdmpdryKekOoncLLv6q0o4QlIR6tO1BTsLxCcXuB32rjjtR3Gst/3v91yHEXq8lDudNwdEnJLP5dDlvmjFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(4326008)(66946007)(2616005)(66556008)(66476007)(8676002)(6666004)(316002)(36756003)(2906002)(83380400001)(38100700002)(6506007)(86362001)(53546011)(41300700001)(6512007)(8936002)(5660300002)(6486002)(31696002)(478600001)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJHVlBtVmpOZmF4N3l2NEEvbW5ISnF5ZmFDcUtMSVZnYlRiSFd1bnltUGJx?=
 =?utf-8?B?WjB6MlZSZVlqTHZuYkdVOVR3bXUxU3ZwNjB3SEZKOXk0UGs5c1dVWnUwS0J6?=
 =?utf-8?B?dmNnVjN1Qk85d0JRMldlNThKNklXdHBGOFMwNDBpa0paV3ROd25OK3oyUnpT?=
 =?utf-8?B?emlhTlFtWkRCZTA1a0FvNUhCdWRUd2VXcnFRSm5WUnVnVmg2NnVFd2l3ZTBr?=
 =?utf-8?B?QU96M2RDSnQzUmlZQ3VKWGxNUnN4bzhKQ25lUE5yVVl5L3ZDemU0aldoZnlQ?=
 =?utf-8?B?M3VteFNoMlJQc3VqTGFSSzA0QlAxVUJINE5OUWlPNjJHZ20zNURma1FOdkJH?=
 =?utf-8?B?Z3VOSlFzS2ZEaE1DcTdNVW5SbTZReEFNSlFUZEx0R3pVSWZhRTZTYlY1N1d0?=
 =?utf-8?B?TXB6OWNiWEU4UHE0am82NXBMbERSekpDN1BBOFQwd1U4ZHptZ3JRWVBXbHRT?=
 =?utf-8?B?dldCSWNWQitMRTlSQ2FKZjdwQ1ZLU1JGUDEreENkS3hFTkZISEtFaXZVTXNy?=
 =?utf-8?B?RDcrVmlOMkNBRjVXZzZvaFhDZnJEc0NOQnMrVkRuZ0pteTFOa3gwYXVoVXhB?=
 =?utf-8?B?NnlyU1o5S1FBdWFMOHVUVjBydk1RVVIzMnRNdE5PM2FCeXhQSjE0VVJ3eVpX?=
 =?utf-8?B?NkY1MXVvcnFlQVp2UFlCSmhkeVFLWjZvbkdWWUNhRGdzakU2SnpsZ3hYbVZH?=
 =?utf-8?B?T1hnaGMzWkZxZ3UrRlI3dXY1byt0eXBjenNFNDNCMUZHc1p2ZjN3SlNkL0hs?=
 =?utf-8?B?RUZyanlkV29hK2xsTURSeDJkdzB5ME5uQWRMTzlwL0NsWGZSM0ZaNFlLQXRz?=
 =?utf-8?B?amhpOXNzR2FUdWd2U3NWWFk2REJNUGRCN1VWRFJKZkhkQncvN3lJNmo4TzFh?=
 =?utf-8?B?cjFZeCs2M2VYMUwxUGFEQmFIYTdJaDF4RjBUR01vZEs3Q2xnY1lZZnBLL3RC?=
 =?utf-8?B?L1NBZDZXL08xQWlUTXpYWmZLbGMwdmxWTVJPTy85TnEydy9RNEkxL0NNMTRO?=
 =?utf-8?B?VmxuS0V0Y0x3NmFpYnJhSGtUMGtZOTJpYXlkamZDc0hZcVdGSTBiL2p1dWVK?=
 =?utf-8?B?cG91YzNrVXBRcHM2bnN0enpYZGdxQ3cwbHNuOGNNeXh6QkQ0MXhpQjZmd1FU?=
 =?utf-8?B?N1E2QTB2c21TdzI3ZS9jaWs0VTJmbzF4K0tVTTVhcHppRTVHQ3dwK0ZXOVZU?=
 =?utf-8?B?c0FQMTc5RTIvRzQ4ZEF5MWlDUEVjdUw1akVldDMzbDlCT3RqV04wdnYvL01i?=
 =?utf-8?B?bjF0WmJUc2h1V3J6UjA3dUlXVlF0WUlxcUN6aFpNVFRna1cxYUNCM3hCaysw?=
 =?utf-8?B?SWpyU1JiNWora01ISzRGS3Iydk9MYnZHanNnRkF3UlFYNEM1VjM0RkdGQmtp?=
 =?utf-8?B?SW5qZjZyeG04SVV1bFVRSVc1MjArZndzV0IzazNXMUlSUllEOUFFSzRveXN3?=
 =?utf-8?B?cDF4UWlxK1ZBQVp5ZTBObm5FTVFMWXN3ek5nNlM5V0NKR2tCZjRVSXJ2OUMw?=
 =?utf-8?B?K1VQOU8zaG52ci9LR2FyYzRsbVdBQWhUL3FMTFBzakR2eFNOR0N3VHgrMXVB?=
 =?utf-8?B?emloM2hnSWpJZ0NROElJMjJoZnhUUDBmcHdKYWxGTzViRXd6NFZTaEhkYXdu?=
 =?utf-8?B?N0crMVhVQVNlQURtRFo3S2RFQ1lCWHpqMFJYQjNtZ25hSndocnZqNXRlWVRD?=
 =?utf-8?B?Y1FseitNRlFJcVFNNFNLQnNNalJOcnhTQzdCd2wvSjU4dXNMRFhmUWZaM25y?=
 =?utf-8?B?TnlrWWpLYS9rWnMzTk5velordEo0VlBZd0tkNmlzQlE1Um9yUGV4dGttN2l0?=
 =?utf-8?B?Y1V0Y1VEZ1A2anlISnR0dEVwV3BzUEFob2pLRUY1a2ROcTlTa0xGN2dsc0Y0?=
 =?utf-8?B?Q3hDWFlWR0wxNkxLckZzN0JnWUo0dVVnelo3c3I1WjdnYVIweGtUcVZseGxS?=
 =?utf-8?B?clp2T0lNRVlGNFJDalk1SWF5VlFyckVjUytzcS9rVExKc2w4UmZId1RqeHpG?=
 =?utf-8?B?K1JIWnhVRzFlTy9FUEhVQTdhTklWd2tvc3pPWEpaTkpzVkFnL2t6bFQ2Yy90?=
 =?utf-8?B?RU5Qa1ROSGtjTVJBdEIzRGRRVitQWW1xbm0vOFM1akdQbWU3bVJrMWpYcThO?=
 =?utf-8?B?UDRKWHpGSDNHRzNOTGRIWTZ6d0ZPZFlXK0djanFaQmdtRnBiMDBaUVIrWmRF?=
 =?utf-8?Q?dmD3T0MGrz+Nt1+DlHufoIRyA3heUfnHn21Uh6q7A9QI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6adb4-adf8-473e-025c-08dab5a3c36e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:40:19.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOovhx7nrL9KDJ2vMMBGtnW92mBWkj5PBv3+AAOn2hsPROPBY9PBicKvI3aANYzWeYhdvvNYojsp0XcoGSjOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9648
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.10.22 15:37, Corentin Labbe wrote:
> The CH348 is an USB octo port serial adapter.
> This patch adds support for it.
> 

Hi,

comments inline.

> +struct ch348_rxbuf {
> +	u8 port;
> +	u8 length;
> +	u8 data[];
> +} __packed;
> +
> +#define CH348_RX_PORT_CHUNK_LENGTH	32
> +#define CH348_RX_PORT_MAX_LENGTH	30
> +
> +struct ch348_txbuf {
> +	u8 port;
> +	__le16 length;
> +	u8 data[];
> +} __packed;
> +

You know how long data will be. Why leave it unspecified?

> +static void ch348_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	u8 *buffer = urb->transfer_buffer, *end;
> +	unsigned int portnum, usblen;
> +	struct ch348_rxbuf *rxb;
> +
> +	if (!urb->actual_length) {

That check needs to be for < 2 or you can process garbage.

> +		dev_warn(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
> +		return;
> +	}
> +
> +	end = buffer + urb->actual_length;
> +
> +	for (; buffer < end; buffer += CH348_RX_PORT_CHUNK_LENGTH) {
> +		rxb = (struct ch348_rxbuf *)buffer;
> +		portnum = rxb->port;
> +		if (portnum >= CH348_MAXPORT) {
> +			dev_warn(&port->dev, "%s:%d invalid port %d\n",
> +				 __func__, __LINE__, portnum);
> +			break;
> +		}
> +
> +		usblen = rxb->length;
> +		if (usblen > 30) {

You have defined a nummerical constant for that. Use it.

> +			dev_warn(&port->dev, "%s:%d invalid length %d for port %d\n",
> +				 __func__, __LINE__, usblen, portnum);
> +			break;
> +		}
> +
> +		port = ch348->ttyport[portnum].port;
> +		tty_insert_flip_string(&port->port, rxb->data, usblen);
> +		tty_flip_buffer_push(&port->port);
> +		port->icount.rx += usblen;
> +		usb_serial_debug_data(&port->dev, __func__, usblen, rxb->data);
> +	}
> +}
> +
> +static int ch348_prepare_write_buffer(struct usb_serial_port *port, void *dest, size_t size)
> +{
> +	struct ch348_txbuf *rxt = dest;
> +	const size_t txhdrsize = offsetof(struct ch348_txbuf, data);

What is that? This is a constant.

> +	int count;
> +
> +	count = kfifo_out_locked(&port->write_fifo, rxt->data,
> +				 size - txhdrsize, &port->lock);
> +
> +	rxt->port = port->port_number;
> +	rxt->length = cpu_to_le16(count);
> +
> +	return count + txhdrsize;
> +}

> +static void ch348_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
> +			      const struct ktermios *termios_old)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	int portnum = port->port_number;
> +	struct ktermios *termios = &tty->termios;
> +	int ret, sent;
> +	__le32	dwDTERate;

OK it is LE.

> +	u8	bCharFormat;
> +	struct ch348_initbuf *buffer;
> +
> +	if (termios_old && !tty_termios_hw_change(&tty->termios, termios_old))
> +		return;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer) {
> +		if (termios_old)
> +			tty->termios = *termios_old;
> +		return;
> +	}
> +
> +	dwDTERate = tty_get_baud_rate(tty);

This is speed_t, in other words unsigned int without specified endianness.

> +	/* test show no success on low baud and datasheet said it is not supported */
> +	if (dwDTERate < 1200)
> +		dwDTERate = DEFAULT_BAUD_RATE;
> +	/* datasheet said it is not supported */
> +	if (dwDTERate > 6000000)
> +		dwDTERate = 6000000;

You are comparing to constants in native endianness.

> +
> +	bCharFormat = termios->c_cflag & CSTOPB ? 2 : 1;
> +
> +	buffer->bParityType = termios->c_cflag & PARENB ?
> +			     (termios->c_cflag & PARODD ? 1 : 2) +
> +			     (termios->c_cflag & CMSPAR ? 2 : 0) : 0;
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		buffer->bDataBits = 5;
> +		break;
> +	case CS6:
> +		buffer->bDataBits = 6;
> +		break;
> +	case CS7:
> +		buffer->bDataBits = 7;
> +		break;
> +	case CS8:
> +	default:
> +		buffer->bDataBits = 8;
> +		break;
> +	}
> +	buffer->cmd = CMD_WB_E | (portnum & 0x0F);
> +	buffer->reg = R_INIT;
> +	buffer->port = portnum;
> +	buffer->dwDTERate = cpu_to_be32(le32_to_cpu(dwDTERate));

So it is native, not LE?

[..]

> +
> +static int ch348_fixup_port_bulk_in(struct ch348 *ch348, struct usb_serial_port *port)
> +{
> +	int i;
> +
> +	/* Already Initialized */
> +	if (port->bulk_in_size) {

BTW, shouldn't these be unsigned int?
[..]

	Regards
		Oliver

