Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776EB5FAC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJKGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJKGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:02:40 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0F12AC4;
        Mon, 10 Oct 2022 23:02:39 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j16so19917418wrh.5;
        Mon, 10 Oct 2022 23:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8oFuI+x6kR8yEhpzpaADt1Pt7upeF77ruYQZxt6LGM=;
        b=6HkKNojXYtDVHoByywH04JDUfFVo5QPO0PUy131tG9teDGsE/cbCHoI0Z2uferbl6S
         793dnBhsRzrBzi3GRIgge9ftXjeCGFvhA1dGnR0k71DfKD8g79rO2In0ZcVdDQUonHr5
         0CtGpLq2H0gGwKod8D+qjWOB4KMbQadRf96xIJXuMHgTXtdsYm3+9GfpwbRra3jNcgUr
         BNjfc9OixWyMDzErcKuGbAbi/uGFHkMRIqhyppAapMEjWiFtTEoT1HveiKf/B2mRCUIS
         EmhUhshyB0dFcZUicKj+TzIFNkF5Nu2PNASutI0JeGS1ZpPKed0mWUzsU75SEgaw3IOg
         tCnA==
X-Gm-Message-State: ACrzQf1pvLkw+ztQ8K5wHKCsFNeaR7MpErv4eTCxZsHwBIpYpDkX0sVG
        0kZCFmYdGuF7oSGRnlYW9gk=
X-Google-Smtp-Source: AMsMyM4sYzCnoUZrJDLxBsXARmm93ntdlJ2SebeXIof0NbiX8qLQAqnVIyPhGzeKtYhnMsGgI4eyNg==
X-Received: by 2002:a05:6000:1843:b0:22e:77b0:2e5 with SMTP id c3-20020a056000184300b0022e77b002e5mr13577737wri.215.1665468157864;
        Mon, 10 Oct 2022 23:02:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d434a000000b00228de351fc0sm10564262wrr.38.2022.10.10.23.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 23:02:37 -0700 (PDT)
Message-ID: <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
Date:   Tue, 11 Oct 2022 08:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221011000840.289033-14-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 10. 22, 2:08, Elliot Berman wrote:
> Gunyah provides a console for each VM using the VM console resource
> manager APIs. This driver allows console data from other
> VMs to be accessed via a TTY device and exports a console device to dump
> Linux's own logs to our console.
...
> +struct rm_cons_drv_data {
> +	struct tty_driver *tty_driver;
> +	struct device *dev;
> +
> +	spinlock_t ports_lock;
> +	struct rm_cons_port *ports[RM_CONS_TTY_ADAPATERS];
> +
> +	struct notifier_block rm_cons_notif;
> +	struct console console;
> +
> +	/* below are for printk console.
> +	 * gh_rm_console_* calls will sleep and console_write can be called from
> +	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
> +	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
> +	 * A work is scheduled to flush the bytes. The work will swap the active buffer
> +	 * and write out the other buffer.
> +	 */

Ugh, why? This is too ugly and unnecessary. What about passing the kfifo 
to gh_rm_console_write() instead? You do memcpy() there anyway.

> +	char *co_xmit_buf[2];
> +	int co_xmit_idx;
> +	unsigned int co_xmit_count;
> +	spinlock_t co_xmit_lock;
> +	struct work_struct co_flush_work;
> +};
> +
> +static int rm_cons_notif_handler(struct notifier_block *nb, unsigned long cmd, void *data)
> +{
> +	int count, i;
> +	struct rm_cons_port *rm_port = NULL;
> +	struct tty_port *tty_port = NULL;
> +	struct rm_cons_drv_data *cons_data =
> +		container_of(nb, struct rm_cons_drv_data, rm_cons_notif);
> +	const struct gh_rm_notification *notif = data;
> +	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;

So you did not comment on/address all my notes?

-- 
js

