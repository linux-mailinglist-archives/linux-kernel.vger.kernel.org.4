Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F556372D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKXHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKXHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:12:25 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C401A3A3;
        Wed, 23 Nov 2022 23:02:53 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id vp12so808538ejc.8;
        Wed, 23 Nov 2022 23:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3BuIHPcCEYQnF5EJCfcvp0uVQ+D0Hs/7ciNa+WMlcA=;
        b=KzGcy01QeOdWUzgYW5tM3T+U6oEIRGhhW6noW9KkpcQ/4GIsN1IKgWOqUAWfgYxSFp
         N2Sfo7TWynApMQ2r+OX7aR91/m2h7zPBwlvxuZmgJ3stnexTnoDGLgajZZp/wOvyTZ+h
         yvyQ15kN3Ql9kZULCyfF5AAgP/W1aCAjEj/Hy7N3i6rdjWGvCPv6ZYEGLYTv8Vd0QTmR
         L49pok4aKYH0FsaZR+jhGXzk7Ci4TnfMkO9g8DOlbShSZGmzioeat99tiubF+j/07lBw
         ItB/g4pvdOY550Uif3UVzaD4ZVaCcCQ6pV22py1uPLPB/AatDkpL1BuY/NZr/cr66Ub6
         dnOA==
X-Gm-Message-State: ANoB5pkrzXTYzu6oAuG8I6FD96GIYGqo+bhfUuzKXvuqswQiuSr4Zzn6
        SxAAo2KYaUHgHkhTGJctPWU=
X-Google-Smtp-Source: AA0mqf5ze7Akj3TpX17yqe7DZ3SpaSkau61h7eALpc4C3+SAElCCuYk2/Zhq28b2wA4a7fw4Jnj1kw==
X-Received: by 2002:a17:906:3810:b0:7b5:cab5:2ea8 with SMTP id v16-20020a170906381000b007b5cab52ea8mr10091575ejc.222.1669273372000;
        Wed, 23 Nov 2022 23:02:52 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bq21-20020a170906d0d500b00781be3e7badsm105054ejb.53.2022.11.23.23.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 23:02:51 -0800 (PST)
Message-ID: <6cce2d35-3504-a600-cae6-fd4abee9afc9@kernel.org>
Date:   Thu, 24 Nov 2022 08:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 00/14] serial: liteuart: add IRQ support
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221123130500.1030189-1-gsomlo@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 11. 22, 14:04, Gabriel Somlo wrote:
> Add IRQ support to the LiteX LiteUART serial interface

LGTM

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

