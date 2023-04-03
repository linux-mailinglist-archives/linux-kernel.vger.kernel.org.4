Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D66D46E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDCOPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjDCOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:15:07 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063131DF99;
        Mon,  3 Apr 2023 07:15:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id CF1F8604FA;
        Mon,  3 Apr 2023 16:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680531300; bh=qvMX0CpC+yvi5bVs8CmZQ3oJUBc0azyKWjYTbBw4duY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bnhI/WzqbSMAs2LEl43+W6tqBNyoOeIUGCqVES1+TLH5tr1X5VErdg9jbnPps/VO6
         Ww1Ia9ajSPk7Y5foQrA8IGrGuunZAQFFsUj6/31PKHyd6JWATgjHp5OL4i6aJwNc/b
         J+Du/DsCCTJGa/nmaljC6ErnsCsfoTFYQCqhPsJxHwFsr4BJhrux16jR/Dk/10v8o8
         WcSHLuiegZbt8+LzVR2DFRUaS1yiF0KDQPADdUvrTugh7hGvGzGiGqppCK0GkWCRWO
         RixvRxyWksgQ844IgSucMGawWxaSmMl2e+A7jlXNXQ78fGrqC6n1LuhMoN6o5FdiV4
         rUl7HekdPs3SQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4qOl-z_8Puww; Mon,  3 Apr 2023 16:14:58 +0200 (CEST)
Received: from [10.0.1.57] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id C09BC604F7;
        Mon,  3 Apr 2023 16:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680531298; bh=qvMX0CpC+yvi5bVs8CmZQ3oJUBc0azyKWjYTbBw4duY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cUcgFb9mMh88fu3dQWaykAqaYeswSWIwo2/Aa1lbnekWQrRrelw8UenUoXFouhTNr
         bsgDPvkuRHVUJGW0qfAqX/1BSfY9GRFzHDToxfSg5zNwwbaov5Sethreq2N+wkl+1X
         vcHXNSxNE0sqHBPJtWM3lxnwha5lGjlsgGMrvhd/OnNWtDWpK3DR52/LIgbSPgJLKQ
         D6B0TorP5H5ZsFgGNo2EifuH/i9n9z/9xu5chf705dyuzQf85/vxLlk2Dm48TvyJrc
         b/waIDsu/jW1SrYLgX7LlEUMOaA2DlliWaS+CKPpytTQWJD3Ftw3K4Y9sHKvPAvwtY
         dVAt+9/ODAZQw==
Message-ID: <e5af5f7e-c59c-aebb-a17a-50a48f3ee3a8@alu.unizg.hr>
Date:   Mon, 3 Apr 2023 16:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH] memstick: fix memory leak if card device is never
 registered
Content-Language: en-US, hr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kay Sievers <kay.sievers@vrfy.org>, stable <stable@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20230401200327.16800-1-gregkh@linuxfoundation.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230401200327.16800-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.4.2023. 22:03, Greg Kroah-Hartman wrote:
> When calling dev_set_name() memory is allocated for the name for the
> struct device.  Once that structure device is registered, or attempted
> to be registerd, with the driver core, the driver core will handle
> cleaning up that memory when the device is removed from the system.
> 
> Unfortunatly for the memstick code, there is an error path that causes
> the struct device to never be registered, and so the memory allocated in
> dev_set_name will be leaked.  Fix that leak by manually freeing it right
> before the memory for the device is freed.
> 
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Kay Sievers <kay.sievers@vrfy.org>
> Cc: linux-mmc@vger.kernel.org
> Fixes: 0252c3b4f018 ("memstick: struct device - replace bus_id with dev_name(),
> Cc: stable <stable@kernel.org>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> RESEND as the first version had a corrupted message id and never made it
> to the mailing lists or lore.kernel.org
> 
>   drivers/memstick/core/memstick.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bf7667845459..bbfaf6536903 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>   	return card;
>   err_out:
>   	host->card = old_card;
> +	kfree_const(card->dev.kobj.name);
>   	kfree(card);
>   	return NULL;
>   }
> @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
>   				put_device(&card->dev);
>   				host->card = NULL;
>   			}
> -		} else
> +		} else {
> +			kfree_const(card->dev.kobj.name);
>   			kfree(card);
> +		}
>   	}
>   
>   out_power_off:

FYI, the applied patch tested OK, no memstick leaks:

[root@pc-mtodorov kernel]# uname -rms
Linux 6.3.0-rc5-mt-20230401-00007-g268a637be362 x86_64
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov kernel]# cat /sys/kernel/debug/kmemleak

What was applied is:

mtodorov@domac:~/linux/kernel/linux_torvalds$ git diff master..origin/master | head -24
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bbfaf6536903..bf7667845459 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -410,7 +410,6 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
         return card;
  err_out:
         host->card = old_card;
-       kfree_const(card->dev.kobj.name);
         kfree(card);
         return NULL;
  }
@@ -469,10 +468,8 @@ static void memstick_check(struct work_struct *work)
                                 put_device(&card->dev);
                                 host->card = NULL;
                         }
-               } else {
-                       kfree_const(card->dev.kobj.name);
+               } else
                         kfree(card);
-               }
         }

  out_power_off:

APPENDIX

However, please note that the patch SHA-1's truncated to 12 chars might not
be the same on the other systems, so the build ID says nothing about which
mainline kernel had the patches been applied against. So `uname -rms` is
telling pretty nothing about which kernel I'm running, except that it helps
me distinguish between the builds.

Nothing to prove that:

- I am not testing the wrong kernel and
- that the right patches have been applied.

Changing CONFIG_LOCALVERSION causes copious recompilations, even with ccache
it takes about 4x the time needed to compile CONFIG_LOCALVERSION_AUTO=y.

Do I make any sense with this?

I am adding Cc: to Mr. Bagas, for we spoke already about kernel versioning
in the case of manually applied patches.

Regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

