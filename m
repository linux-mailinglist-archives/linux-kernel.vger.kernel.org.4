Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A915FAEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJKJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJKJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:03:54 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0F7C325;
        Tue, 11 Oct 2022 02:03:42 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef0e.dynamic.kabel-deutschland.de [95.90.239.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 38BC661EA192D;
        Tue, 11 Oct 2022 11:03:40 +0200 (CEST)
Message-ID: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
Date:   Tue, 11 Oct 2022 11:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Do not delay boot when printing log to serial console during startup?
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


We boot our systems generally with the serial console enabled 
`console=ttyS0,115200n8`, and noticed that initializing the console 
takes at least one second.

     $ dmesg | grep -e 'DMI:' -e 'printk: console'
     [    0.000000] DMI: Dell Inc. PowerEdge R7525/05Y13N, BIOS 2.7.3 
03/30/2022
     [    2.691432] printk: console [tty0] enabled
     [    5.414384] printk: console [ttyS0] enabled

     $ dmesg | grep -e 'DMI:' -e 'printk:'
     [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 
2.22.0 07/13/2022
     [    0.146953] printk: console [tty0] enabled
     [    1.374382] printk: console [ttyS0] enabled

     $ dmesg | grep -e 'DMI:' -e 'printk: console'
     [    0.000000] DMI: Dell Inc. PowerEdge R7425/08V001, BIOS 1.6.7 
10/29/2018
     [    1.589543] printk: console [tty0] enabled
     [    3.057770] printk: console [ttyS0] enabled

     $ dmesg | grep -e 'DMI:' -e 'printk: console'
     [    0.000000] DMI: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 
Gen10 Plus, BIOS A42 12/03/2021
     [    5.171202] printk: console [tty0] enabled
     [    8.066602] printk: console [ttyS0] enabled

`initcall_debug` shows:

     [    0.190491] calling  univ8250_console_init+0x0/0x2b @ 0
     [    1.488645] printk: console [ttyS0] enabled
     [    1.492945] initcall univ8250_console_init+0x0/0x2b returned 0 
after 0 usecs

(Note, that the “after time” by initcall does not match the timestamp at 
the beginning.)

Tracing with the trace *function* (`ftrace=function`) shows:

           <idle>-0       [000] ...2.     0.213187: 
univ8250_console_init <-console_init
           <idle>-0       [000] ...2.     0.213187: 
serial8250_isa_init_ports <-univ8250_console_init
           <idle>-0       [000] ...2.     0.213187: serial8250_init_port 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213187: init_timer_key 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213187: 
serial8250_set_defaults <-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: serial8250_init_port 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: init_timer_key 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: 
serial8250_set_defaults <-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: serial8250_init_port 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: init_timer_key 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: 
serial8250_set_defaults <-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: serial8250_init_port 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: init_timer_key 
<-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213188: 
serial8250_set_defaults <-serial8250_isa_init_ports
           <idle>-0       [000] ...2.     0.213189: register_console 
<-univ8250_console_init
           <idle>-0       [000] ...2.     0.213189: 
try_enable_preferred_console <-register_console
           <idle>-0       [000] ...2.     0.213189: 
univ8250_console_match <-try_enable_preferred_console
           <idle>-0       [000] ...2.     0.213189: 
univ8250_console_setup <-try_enable_preferred_console
           <idle>-0       [000] ...2.     0.213189: 
serial8250_console_setup <-univ8250_console_setup
           <idle>-0       [000] ...2.     0.213189: uart_parse_options 
<-serial8250_console_setup
           <idle>-0       [000] ...2.     0.213190: uart_set_options 
<-serial8250_console_setup
           <idle>-0       [000] ...2.     0.213190: 
tty_termios_encode_baud_rate <-uart_set_options
           <idle>-0       [000] ...2.     0.213190: 
serial8250_set_termios <-uart_set_options
           <idle>-0       [000] ...2.     0.213191: 
serial8250_do_set_termios <-uart_set_options
           <idle>-0       [000] ...2.     0.213191: tty_get_char_size 
<-serial8250_do_set_termios
           <idle>-0       [000] ...2.     0.213191: uart_get_baud_rate 
<-serial8250_do_set_termios
           <idle>-0       [000] ...2.     0.213191: 
tty_termios_baud_rate <-uart_get_baud_rate
           <idle>-0       [000] ...2.     0.213191: 
serial8250_get_divisor <-serial8250_do_set_termios
           <idle>-0       [000] ...2.     0.213191: uart_get_divisor 
<-serial8250_get_divisor
           <idle>-0       [000] ...2.     0.213191: 
_raw_spin_lock_irqsave <-serial8250_do_set_termios
           <idle>-0       [000] d..2.     0.213192: preempt_count_add 
<-_raw_spin_lock_irqsave
           <idle>-0       [000] d..3.     0.213192: uart_update_timeout 
<-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213192: tty_get_frame_size 
<-uart_update_timeout
           <idle>-0       [000] d..3.     0.213192: io_serial_out 
<-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213195: 
serial8250_do_set_divisor <-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213195: io_serial_out 
<-serial8250_do_set_divisor
           <idle>-0       [000] d..3.     0.213198: 
default_serial_dl_write <-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213198: io_serial_out 
<-default_serial_dl_write
           <idle>-0       [000] d..3.     0.213201: io_serial_out 
<-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213204: io_serial_out 
<-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213207: io_serial_out 
<-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213210: 
serial8250_do_set_mctrl <-serial8250_do_set_termios
           <idle>-0       [000] d..3.     0.213210: io_serial_out 
<-serial8250_do_set_mctrl
           <idle>-0       [000] d..3.     0.213213: 
_raw_spin_unlock_irqrestore <-serial8250_do_set_termios
           <idle>-0       [000] ...3.     0.213213: preempt_count_sub 
<-_raw_spin_unlock_irqrestore
           <idle>-0       [000] ...2.     0.213213: 
tty_termios_baud_rate <-serial8250_do_set_termios
           <idle>-0       [000] ...2.     0.213214: 
tty_termios_encode_baud_rate <-serial8250_do_set_termios
           <idle>-0       [000] ...2.     0.213214: console_lock 
<-register_console
           <idle>-0       [000] ...2.     0.213214: __cond_resched 
<-console_lock
           <idle>-0       [000] ...2.     0.213214: down <-console_lock
           <idle>-0       [000] ...2.     0.213214: __cond_resched <-down
           <idle>-0       [000] ...2.     0.213214: 
_raw_spin_lock_irqsave <-down
           <idle>-0       [000] d..2.     0.213214: preempt_count_add 
<-_raw_spin_lock_irqsave
           <idle>-0       [000] d..3.     0.213214: 
_raw_spin_unlock_irqrestore <-console_lock
           <idle>-0       [000] ...3.     0.213214: preempt_count_sub 
<-_raw_spin_unlock_irqrestore
           <idle>-0       [000] ...2.     0.213214: mutex_lock 
<-register_console
           <idle>-0       [000] ...2.     0.213215: __cond_resched 
<-mutex_lock
           <idle>-0       [000] ...2.     0.213215: mutex_unlock 
<-register_console
           <idle>-0       [000] ...2.     0.213215: console_unlock 
<-register_console
           <idle>-0       [000] ...2.     0.213215: 
console_emit_next_record.constprop.0 <-console_unlock
           <idle>-0       [000] ...2.     0.213215: prb_read_valid 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] ...2.     0.213215: _prb_read_valid 
<-prb_read_valid
           <idle>-0       [000] ...2.     0.213215: 
desc_read_finalized_seq <-_prb_read_valid
           <idle>-0       [000] ...2.     0.213215: 
console_emit_next_record.constprop.0 <-console_unlock
           <idle>-0       [000] ...2.     0.213215: prb_read_valid 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] ...2.     0.213215: _prb_read_valid 
<-prb_read_valid
           <idle>-0       [000] ...2.     0.213215: 
desc_read_finalized_seq <-_prb_read_valid
           <idle>-0       [000] ...2.     0.213216: get_data 
<-_prb_read_valid
           <idle>-0       [000] ...2.     0.213216: 
desc_read_finalized_seq <-_prb_read_valid
           <idle>-0       [000] ...2.     0.213216: record_print_text 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] ...2.     0.213216: info_print_prefix 
<-record_print_text
           <idle>-0       [000] d..2.     0.213216: __printk_safe_enter 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] d..2.     0.213216: _raw_spin_lock 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] d..2.     0.213216: preempt_count_add 
<-_raw_spin_lock
           <idle>-0       [000] d..3.     0.213216: _raw_spin_unlock 
<-console_emit_next_record.constprop.0
           <idle>-0       [000] d..3.     0.213217: preempt_count_sub 
<-_raw_spin_unlock
           <idle>-0       [000] d..2.     0.213217: 
univ8250_console_write <-console_emit_next_record.constprop.0
           <idle>-0       [000] d..2.     0.213217: 
serial8250_console_write <-console_emit_next_record.constprop.0
           <idle>-0       [000] d..2.     0.213217: 
_raw_spin_lock_irqsave <-serial8250_console_write
           <idle>-0       [000] d..2.     0.213217: preempt_count_add 
<-_raw_spin_lock_irqsave
           <idle>-0       [000] d..3.     0.213217: io_serial_in 
<-serial8250_console_write
           <idle>-0       [000] d..3.     0.213220: io_serial_out 
<-serial8250_console_write
           <idle>-0       [000] d..3.     0.213223: uart_console_write 
<-serial8250_console_write
           <idle>-0       [000] d..3.     0.213223: 
serial8250_console_putchar <-uart_console_write
           <idle>-0       [000] d..3.     0.213223: wait_for_xmitr 
<-serial8250_console_putchar
           <idle>-0       [000] d..3.     0.213223: io_serial_in 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213226: io_serial_out 
<-uart_console_write
           <idle>-0       [000] d..3.     0.213229: 
serial8250_console_putchar <-uart_console_write
           <idle>-0       [000] d..3.     0.213229: wait_for_xmitr 
<-serial8250_console_putchar
           <idle>-0       [000] d..3.     0.213229: io_serial_in 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213232: __const_udelay 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213232: delay_tsc 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213233: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213233: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213233: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213233: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213233: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213233: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213233: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213233: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213233: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213233: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213234: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213234: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213234: io_serial_in 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213237: __const_udelay 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213237: delay_tsc 
<-wait_for_xmitr
           <idle>-0       [000] d..3.     0.213237: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213237: preempt_count_sub 
<-delay_tsc
           <idle>-0       [000] d..3.     0.213237: preempt_count_add 
<-delay_tsc
           <idle>-0       [000] d..4.     0.213237: preempt_count_sub 
<-delay_tsc

So it looks to me like, that the already recorded messages are printed 
out over the serial console first, before it continues. The 
documentation of `register_console()` in `kernel/printk/printk.c` 
confirms that:

>  * The console driver calls this routine during kernel initialization
>  * to register the console printing procedure with printk() and to
>  * print any messages that were printed by the kernel before the
>  * console driver was initialized.

Is there an option to enable the serial console but send the messages to 
it asynchronously so it does not hold up the boot?


Kind regards,

Paul
