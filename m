Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511A707B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjERIBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjERIBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:01:05 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD52708;
        Thu, 18 May 2023 01:00:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7B0C860173;
        Thu, 18 May 2023 10:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684396843; bh=d02Uw1o7ei0qXRNWctuY3MCRE3pmghS5xgEUwxNhwkg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KgW/umBSkF0WjYdsoKHiLB45Um0cBYWtGtfmacCc5P0kQarTneXGlNvCxGy05blDN
         Zd+MXpxIHmBLxyypsFvQKT+X1TuQwmCEEwjugJlyECYGg1R2Nd2u4Qn16XSfiRKi1S
         R+9qea5bhc3BlgGtTJPz+RsfbzNNHyE69yTYyfdzWjHDIWp227Y5p4zNglvAoBC+f7
         MxUqpAabJTMF13aKFucRcuehdsd72uNmjqa8a17p+0NWc2rje8RcHoSfiJTLiNuo/s
         KkjYYoohJIMZlpN3/ZIu42AatYxGs6SLo6F4M72M3p7wsqVeNIaqDjk49Sx3SjIpaa
         Qlzf3nvjVElDg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nnDtl1L0V8Vj; Thu, 18 May 2023 10:00:41 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 06CF460171;
        Thu, 18 May 2023 10:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684396841; bh=d02Uw1o7ei0qXRNWctuY3MCRE3pmghS5xgEUwxNhwkg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZPjM40Rc/4mmWx7D69vqErg/uOoxoDXYHTwKWyfERFES2Cz71f3w1dr+KD+LT80ME
         VhrFYA6Zcf+BuzH6sBjCboR1EOEjVuSVPjlZ6nbcuu64COBZsqh3L/uKR4yxTI9GYI
         2u+zROYcETgmMAGulYoqiVng8Ji9Oybuo38WLUu4/lX8bm0AD1NjHT+PlecOrL7s6g
         VrjE80MXIKyBnVufir1OEtgSEZrmNuJJ1e9UwbTBp1cUWdK6bjBv/ATEXh9RWmJVtr
         Hhm11XB9uva84sYKxT498v8KsJ6xKVtFcZeUVoS1crk4SJVZvJaoqQC96QUMIkoxGM
         w8i3Nf7Xw69qQ==
Message-ID: <b84fa328-91c2-fe02-da17-993236d91c81@alu.unizg.hr>
Date:   Thu, 18 May 2023 10:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG][NEW DATA] Kmemleak, possibly hiddev_connect(), in 6.3.0+
 torvalds tree commit gfc4354c6e5c2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
References: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
 <2023050824-juiciness-catching-9290@gregkh>
 <2023050854-collage-dreamt-660c@gregkh>
 <c73471aa-522a-83a4-5614-506581604301@alu.unizg.hr>
 <2023050958-precut-vividly-94bf@gregkh>
 <987f9008-7eac-e2a4-31f6-8479f0e4a626@alu.unizg.hr>
 <2023051607-sturdy-jiffy-ca99@gregkh>
 <70dd7fa2-9a5f-9361-ebe0-bb337c523d09@alu.unizg.hr>
 <2023051704-basket-hardcover-1a0c@gregkh>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023051704-basket-hardcover-1a0c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 20:57, Greg Kroah-Hartman wrote:

> And leaks are hard to notice, especially ones that only show up when you
> remove a specific type of device.
> 
> thanks again for your help here,

I feel like more of a hindrance from the real issues than being helpful.

Memory leaks seem easy to detect, however, building with KMEMLEAK
debugging on can take up to 50-67% of system time, as I've noticed
a couple of days ago ...

It is obviously incurring some overhead. I did not expect a kernel compilation
as computation-heavy process to have such an impact from memory object
debugging.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
