Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1726BFBD5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCRRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:19:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567FE39E;
        Sat, 18 Mar 2023 10:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70136B806A1;
        Sat, 18 Mar 2023 17:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74683C433D2;
        Sat, 18 Mar 2023 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679159970;
        bh=TlLbFe2AtUWFg73uowAriW9X3Ln7J8/MMonCpaLQ7qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nufTb8rQPNuar3fPQ0dMH5Hyw3V10Gjszee7hb7wLvSi4HMEM4AKOrAlbY723QHtT
         dgs2tVBu5NTzPy8C1UQFSgTnHumqLc2Td2TDVIRjk7+uMUh2qU4B4rs3Kilbl0/RjV
         hgeHeQkQpNycHhjGgtPfOgetWn1e98Y4QviFiJEE/BkAsKdz4RCincWl0TyacvNuel
         0olbewnw3DCuIRvLdZadXBxLqiLt9Wl1FoFEOMcc5hswgCrg3vEXd1y3uJD6m6Mf8x
         JjoIO2oH1yoafj9jNqSWbCi5ridX/xu3BkB9hUKVnHLog8B/4pEHwjeTgdL7+RsWO5
         mmm321tY7dzEQ==
Date:   Sat, 18 Mar 2023 17:34:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
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
Subject: Re: [PATCH v2 4/4] serial: qcom_geni: Use devm_krealloc_array
Message-ID: <20230318173402.20a4f60d@jic23-huawei>
In-Reply-To: <74d8b579-6ea8-d6f3-170f-ea13534b4565@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
        <20230309150334.216760-5-james.clark@arm.com>
        <20230311191800.74ec2b84@jic23-huawei>
        <74d8b579-6ea8-d6f3-170f-ea13534b4565@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 11:34:49 +0000
James Clark <james.clark@arm.com> wrote:

> On 11/03/2023 19:18, Jonathan Cameron wrote:
> > On Thu,  9 Mar 2023 15:03:33 +0000
> > James Clark <james.clark@arm.com> wrote:
> >   
> >> Now that it exists, use it instead of doing the multiplication manually.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>  
> > 
> > Hmm. I've stared at the users of this for a bit, and it's not actually obvious
> > that it's being used as an array of u32.  The only typed user of this is as
> > the 2nd parameter of  
> > tty_insert_flip_string() which is an unsigned char *
> > 
> > I wonder if that sizeof(u32) isn't a 'correct' description of where the 4 is coming
> > from even if it has the right value?  Perhaps the fifo depth is just a multiple of 4?
> > 
> > Jonathan
> >   
> 
> The commit that added it (b8caf69a6946) seems to hint that something
> reads from it in words. And I see this:
> 
>   /* We always configure 4 bytes per FIFO word */
>   #define BYTES_PER_FIFO_WORD		4U
> 
> Perhaps sizeof(u32) isn't as accurate of a description as using
> BYTES_PER_FIFO_WORD but I'd be reluctant to make a change because I
> don't really understand the implications.

Agreed with your analysis.  + fully understand why you don't want to change
it. 

I'd be tempted to take the view that whilst it's allocated in 4 byte chunks
because it's accessed elsewhere as a set of 1 byte entries, krealloc_array
isn't appropriate and so just leave it with devm_krealloc()

Risk is that a steady stream of patches will turn up 'fixing' this as
it will be easy for people to find with a script.  Maybe better to just add
a comment (either with or without your patch).
> 
> There is also this in handle_rx_console():
> 
>   unsigned char buf[sizeof(u32)];
> 
> James
> 
> > 
> >   
> >> ---
> >>  drivers/tty/serial/qcom_geni_serial.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> >> index d69592e5e2ec..23fc33d182ac 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -1056,9 +1056,9 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
> >>  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
> >>  
> >>  	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
> >> -		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
> >> -					     port->rx_fifo_depth * sizeof(u32),
> >> -					     GFP_KERNEL);
> >> +		port->rx_buf = devm_krealloc_array(uport->dev, port->rx_buf,
> >> +						   port->rx_fifo_depth, sizeof(u32),
> >> +						   GFP_KERNEL);
> >>  		if (!port->rx_buf)
> >>  			return -ENOMEM;
> >>  	}  
> >   

