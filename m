Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A116F688844
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjBBU3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBBU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:29:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FC8A45;
        Thu,  2 Feb 2023 12:29:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D88261CB8;
        Thu,  2 Feb 2023 20:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E06C433EF;
        Thu,  2 Feb 2023 20:29:35 +0000 (UTC)
Date:   Thu, 2 Feb 2023 15:29:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 2/2] fsi: Add IBM I2C Responder virtual FSI master
Message-ID: <20230202152932.34ce6304@rorschach.local.home>
In-Reply-To: <20230202191926.133340-3-eajames@linux.ibm.com>
References: <20230202191926.133340-1-eajames@linux.ibm.com>
        <20230202191926.133340-3-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Feb 2023 13:19:26 -0600
Eddie James <eajames@linux.ibm.com> wrote:

> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(i2cr_i2c_error,
> +	TP_PROTO(const struct i2c_client *client, __be32 command, int rc),
> +	TP_ARGS(client, command, rc),
> +	TP_STRUCT__entry(
> +		__field(int, bus)
> +		__field(unsigned short, addr)

For all of these, I would put the "unsigned short addr" at the end of
the TP_STRUCT__entry(). That's because you will inject two wasted bytes
in the structure that is generated. Granted, the tracing will likely
word align the result anyway, but still, we don't want holes in the
middle of the structure.

-- Steve


> +		__array(unsigned char, command, sizeof(__be32))
> +		__field(int, rc)
> +	),
> +	TP_fast_assign(
> +		__entry->bus = client->adapter->nr;
> +		__entry->addr = client->addr;
> +		memcpy(__entry->command, &command, sizeof(__be32));
> +		__entry->rc = rc;
> +	),
> +	TP_printk("%d-%02x command:{ %*ph } rc:%d", __entry->bus, __entry->addr,
> +		  (int)sizeof(__be32), __entry->command, __entry->rc)
> +);
> +
> +TRACE_EVENT(i2cr_read,
> +	TP_PROTO(const struct i2c_client *client, uint32_t address, size_t size, __be64 result),
> +	TP_ARGS(client, address, size, result),
> +	TP_STRUCT__entry(
> +		__field(int, bus)
> +		__field(unsigned short, addr)
> +		__field(uint32_t, address)
> +		__field(size_t, size)
> +		__array(unsigned char, result, sizeof(__be64))
> +	),
> +	TP_fast_assign(
> +		__entry->bus = client->adapter->nr;
> +		__entry->addr = client->addr;
> +		__entry->address = address;
> +		__entry->size = size;
> +		memcpy(__entry->result, &result, sizeof(__be64));
> +	),
> +	TP_printk("%d-%02x address:%08x size:%zu { %*ph }", __entry->bus, __entry->addr,
> +		  __entry->address, __entry->size, (int)__entry->size, __entry->result)
> +);
> +
