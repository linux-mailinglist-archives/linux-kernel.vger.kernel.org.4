Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C16BE87A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCQLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCQLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:42:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95436A7295;
        Fri, 17 Mar 2023 04:42:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4C621480;
        Fri, 17 Mar 2023 04:35:33 -0700 (PDT)
Received: from [10.57.17.87] (unknown [10.57.17.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D06D3F885;
        Fri, 17 Mar 2023 04:34:47 -0700 (PDT)
Message-ID: <74d8b579-6ea8-d6f3-170f-ea13534b4565@arm.com>
Date:   Fri, 17 Mar 2023 11:34:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/4] serial: qcom_geni: Use devm_krealloc_array
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230309150334.216760-1-james.clark@arm.com>
 <20230309150334.216760-5-james.clark@arm.com>
 <20230311191800.74ec2b84@jic23-huawei>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230311191800.74ec2b84@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2023 19:18, Jonathan Cameron wrote:
> On Thu,  9 Mar 2023 15:03:33 +0000
> James Clark <james.clark@arm.com> wrote:
> 
>> Now that it exists, use it instead of doing the multiplication manually.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Hmm. I've stared at the users of this for a bit, and it's not actually obvious
> that it's being used as an array of u32.  The only typed user of this is as
> the 2nd parameter of  
> tty_insert_flip_string() which is an unsigned char *
> 
> I wonder if that sizeof(u32) isn't a 'correct' description of where the 4 is coming
> from even if it has the right value?  Perhaps the fifo depth is just a multiple of 4?
> 
> Jonathan
> 

The commit that added it (b8caf69a6946) seems to hint that something
reads from it in words. And I see this:

  /* We always configure 4 bytes per FIFO word */
  #define BYTES_PER_FIFO_WORD		4U

Perhaps sizeof(u32) isn't as accurate of a description as using
BYTES_PER_FIFO_WORD but I'd be reluctant to make a change because I
don't really understand the implications.

There is also this in handle_rx_console():

  unsigned char buf[sizeof(u32)];

James

> 
> 
>> ---
>>  drivers/tty/serial/qcom_geni_serial.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index d69592e5e2ec..23fc33d182ac 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1056,9 +1056,9 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>>  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>>  
>>  	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
>> -		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
>> -					     port->rx_fifo_depth * sizeof(u32),
>> -					     GFP_KERNEL);
>> +		port->rx_buf = devm_krealloc_array(uport->dev, port->rx_buf,
>> +						   port->rx_fifo_depth, sizeof(u32),
>> +						   GFP_KERNEL);
>>  		if (!port->rx_buf)
>>  			return -ENOMEM;
>>  	}
> 
